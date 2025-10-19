/// Yuya FFI Loader - AOT Binary Executor
/// 
/// This executes the compiled AOT binary to perform WCAG validation.
/// NO source code from yuya-core is used - only the compiled binary.

library;

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'core/yuya_data_structures.dart' show WidgetData;

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

    final tempDir = Directory.systemTemp.createTempSync('yuya_');
    final inputFile = File(path.join(tempDir.path, 'input.json'));
    final outputFile = File(path.join(tempDir.path, 'output.json'));

    try {
      // Write input data
      final inputData = {
        'function': 'validateFormLabels',
        'widgets': widgetData.map((w) => w.toJson()).toList(),
      };
      inputFile.writeAsStringSync(jsonEncode(inputData));

      // Execute binary synchronously
      final result = Process.runSync(
        _executablePath!,
        [inputFile.path, outputFile.path],
      );

      if (result.exitCode != 0) {
        throw Exception(
          'AOT binary failed with exit code ${result.exitCode}\n'
          'stderr: ${result.stderr}',
        );
      }

      // Read output
      if (!outputFile.existsSync()) {
        throw Exception('AOT binary did not produce output file');
      }

      final outputJson = jsonDecode(outputFile.readAsStringSync());
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
  FormLabelsResult checkFormLabels(List<WidgetData> widgetData) {
    return _executeAOTSync(widgetData);
  }
}
