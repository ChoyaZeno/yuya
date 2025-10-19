/// Yuya FFI Loader - AOT Binary Executor
/// 
/// This executes the compiled AOT binary to perform WCAG validation.
/// NO source code from yuya-core is used - only the compiled binary.

library;

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

/// Widget data to send to AOT engine
class WidgetData {
  final String type;
  final int index;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool? hasValue;

  const WidgetData({
    required this.type,
    required this.index,
    this.labelText,
    this.hintText,
    this.helperText,
    this.hasValue,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'index': index,
        'labelText': labelText,
        'hintText': hintText,
        'helperText': helperText,
        'hasValue': hasValue,
      };
}

/// Validation result from AOT engine
class FormLabelsResult {
  final bool passed;
  final List<String> issues;
  final int totalElements;
  final String errorMessage;

  const FormLabelsResult({
    required this.passed,
    required this.issues,
    required this.totalElements,
    required this.errorMessage,
  });

  factory FormLabelsResult.fromJson(Map<String, dynamic> json) =>
      FormLabelsResult(
        passed: json['passed'] as bool,
        issues: (json['issues'] as List<dynamic>).cast<String>(),
        totalElements: json['totalElements'] as int,
        errorMessage: json['errorMessage'] as String? ?? '',
      );
}

/// Main class for WCAG form validation using AOT binary
class YuyaFFILoader {
  String? _executablePath;
  static const String _defaultExeName = 'yuya_plugin';

  /// Initialize the loader and locate the AOT executable
  Future<void> initialize() async {
    final pathsToTry = [
      'assets/$_defaultExeName',
      path.join(Directory.current.path, 'assets', _defaultExeName),
      _defaultExeName, // In PATH
    ];

    for (final testPath in pathsToTry) {
      try {
        final file = File(testPath);
        if (file.existsSync()) {
          _executablePath = file.absolute.path;
          return;
        }
      } catch (e) {
        // Continue to next path
      }
    }

    throw Exception(
      '❌ AOT executable not found!\n'
      'Searched paths: ${pathsToTry.join(', ')}\n'
      'Please ensure yuya_plugin executable is in the assets directory.',
    );
  }

  /// Execute the AOT binary with widget data (synchronous)
  FormLabelsResult _executeAOTSync(List<WidgetData> widgetData) {
    if (_executablePath == null) {
      throw Exception('AOT binary not initialized. Call initialize() first.');
    }

    // Prepare input JSON
    final inputData = {
      'function': 'validateFormLabels',
      'widgets': widgetData.map((w) => w.toJson()).toList(),
    };
    final inputJson = jsonEncode(inputData);

    // Create temporary file for input
    final tempDir = Directory.systemTemp.createTempSync('yuya_');
    final inputFile = File(path.join(tempDir.path, 'input.json'));
    inputFile.writeAsStringSync(inputJson);

    try {
      // Execute the binary synchronously
      final result = Process.runSync(
        _executablePath!,
        [inputFile.path],
      );

      if (result.exitCode != 0) {
        throw Exception(
          'AOT execution failed:\n'
          'Exit code: ${result.exitCode}\n'
          'Stderr: ${result.stderr}\n'
          'Stdout: ${result.stdout}',
        );
      }

      // Parse output JSON
      final outputJson = jsonDecode(result.stdout as String) as Map<String, dynamic>;
      return FormLabelsResult.fromJson(outputJson);
    } finally {
      // Cleanup
      try {
        tempDir.deleteSync(recursive: true);
      } catch (e) {
        // Ignore cleanup errors
      }
    }
  }

  /// Check form labels for WCAG compliance
  Future<FormLabelsResult> checkFormLabels(WidgetTester tester) async {
    final widgetDataList = <WidgetData>[];
    int textFieldIndex = 0;
    int dropdownIndex = 0;

    // Extract TextField data
    final textFields = find.byType(TextField);
    for (final textField in textFields.evaluate()) {
      final textFieldWidget = textField.widget as TextField;
      final decoration = textFieldWidget.decoration;

      widgetDataList.add(WidgetData(
        type: 'TextField',
        index: textFieldIndex++,
        labelText: decoration?.labelText,
        hintText: decoration?.hintText,
        helperText: decoration?.helperText,
      ));
    }

    // Extract DropdownButton data
    final dropdowns = find.byType(DropdownButton);
    for (final dropdown in dropdowns.evaluate()) {
      final dropdownWidget = dropdown.widget as DropdownButton;

      String? hintText;
      if (dropdownWidget.hint is Text) {
        hintText = (dropdownWidget.hint as Text).data ??
            (dropdownWidget.hint as Text).textSpan?.toPlainText();
      }

      widgetDataList.add(WidgetData(
        type: 'DropdownButton',
        index: dropdownIndex++,
        hintText: hintText,
        hasValue: dropdownWidget.value != null,
      ));
    }

    // Execute AOT binary for validation
    // NO source code dependency - only compiled binary
    // Using sync execution to avoid async issues in flutter test environment
    return _executeAOTSync(widgetDataList);
  }
}
