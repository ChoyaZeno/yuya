/// Yuya FFI Loader - Loads AOT-compiled validation engine
/// This provides secure, compiled access to the WCAG validation algorithms

library;

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

// Development fallback - only used when AOT is not available
// In production, remove this dependency and distribute AOT binary only
import 'package:yuya_core/yuya_core.dart' as core;

/// Widget data to send to AOT engine (mirrored from yuya-core)
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

/// Validation result from AOT engine (mirrored from yuya-core)
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
        issues: List<String>.from(json['issues'] as List),
        totalElements: json['totalElements'] as int,
        errorMessage: json['errorMessage'] as String,
      );
}

/// YuyaPlugin class - provides access to AOT-compiled WCAG validation
class YuyaPlugin {
  String? _aotPath;
  bool _useAOT = false;
  static const String _defaultAOTPath = 'assets/yuya_plugin.aot';

  /// Initialize with path to AOT snapshot
  /// Falls back to bundled asset if not specified
  Future<void> initialize([String? aotPath]) async {
    // Try specified path, then default asset path
    final pathsToTry = [
      if (aotPath != null) aotPath,
      _defaultAOTPath,
      path.join(Directory.current.path, _defaultAOTPath),
    ];

    for (final testPath in pathsToTry) {
      final file = File(testPath);
      if (await file.exists()) {
        _aotPath = testPath;
        _useAOT = true;
        print('✅ Yuya initialized with protected AOT engine at: $testPath');
        return;
      }
    }

    print('⚠️  AOT snapshot not found, functionality may be limited');
    print('   Searched paths: ${pathsToTry.join(', ')}');
    _useAOT = false;
  }

  /// Extract widget data from WidgetTester
  List<WidgetData> _extractWidgetData(WidgetTester tester) {
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

    return widgetDataList;
  }

  /// Call the AOT engine via isolate
  /// This is where the PROTECTED validation happens
  Future<FormLabelsResult> _callAOTEngine(List<WidgetData> widgetData) async {
    if (!_useAOT || _aotPath == null) {
      // Fallback: Use development mode with direct import
      // NOTE: In production, remove yuya-core dependency for full protection
      print('ℹ️  Using development fallback (yuya-core package)');
      print('   For production: distribute AOT binary only');
      
      final result = core.YuyaAOTEngine.validateFormLabels(
        widgetData.map((w) => core.WidgetData(
          type: w.type,
          index: w.index,
          labelText: w.labelText,
          hintText: w.hintText,
          helperText: w.helperText,
          hasValue: w.hasValue,
        )).toList(),
      );
      return FormLabelsResult.fromJson(result.toJson());
    }

    // Production mode: Use AOT snapshot via isolate
    // This keeps the validation algorithms PROTECTED in compiled binary
    print('🔒 Using PROTECTED AOT engine: $_aotPath');
    
    final receivePort = ReceivePort();
    
    try {
      // Serialize widget data to JSON for sending to isolate
      final widgetDataJson = widgetData.map((w) => w.toJson()).toList();
      
      // Spawn isolate from AOT snapshot
      // NOTE: This requires the Dart VM to be available
      // The validation algorithm source code is NOT accessible
      await Isolate.spawnUri(
        Uri.file(_aotPath!),
        ['validateFormLabels'],
        {
          'port': receivePort.sendPort,
          'data': widgetDataJson,
        },
      );

      // Wait for response from isolate
      final response = await receivePort.first as Map<String, dynamic>;
      
      return FormLabelsResult.fromJson(response);
    } catch (e) {
      // If isolate spawning fails, try development fallback
      print('⚠️  Failed to use AOT isolate: $e');
      print('   Falling back to development mode...');
      
      final result = core.YuyaAOTEngine.validateFormLabels(
        widgetData.map((w) => core.WidgetData(
          type: w.type,
          index: w.index,
          labelText: w.labelText,
          hintText: w.hintText,
          helperText: w.helperText,
          hasValue: w.hasValue,
        )).toList(),
      );
      return FormLabelsResult.fromJson(result.toJson());
    } finally {
      receivePort.close();
    }
  }

  /// Test form labels using the PROTECTED AOT validation engine
  /// 
  /// Architecture:
  /// 1. Extract widget data (public repo - this file)
  /// 2. Send to AOT engine via isolate (PROTECTED - compiled binary)
  /// 3. Receive validation results
  /// 4. Throw if issues found
  /// 
  /// The validation algorithms are in the compiled .aot file,
  /// not accessible in source form.
  Future<void> checkFormLabels(WidgetTester tester) async {
    // Extract widget data (public code - data extraction only)
    final widgetData = _extractWidgetData(tester);

    // Call the PROTECTED validation engine
    // This executes the compiled AOT binary
    final result = await _callAOTEngine(widgetData);

    // Throw if validation failed
    if (!result.passed) {
      fail(result.errorMessage);
    }
  }
}
