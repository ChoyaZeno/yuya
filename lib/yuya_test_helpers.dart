/// Yuya Test Helpers
/// 
/// Convenience methods for using Yuya in flutter_test environments.
/// These provide a clean, direct API similar to flutter_test matchers.

library;

import 'package:flutter_test/flutter_test.dart';
import 'yuya_grpc_client.dart';

/// Yuya test helpers for WCAG validation
/// 
/// Example usage:
/// ```dart
/// testWidgets('form has proper labels', (tester) async {
///   await tester.pumpWidget(MyForm());
///   
///   // Clean, simple API
///   await Yuya.testFormLabels(tester);
/// });
/// ```
class Yuya {
  static YuyaGrpcClient? _client;
  static bool _initialized = false;

  /// Initialize the Yuya validation service (call once per test suite)
  static Future<void> initialize() async {
    if (_initialized) return;
    _client = YuyaGrpcClient();
    await _client!.initialize();
    _initialized = true;
  }

  /// Shutdown the Yuya validation service (call in tearDownAll)
  static Future<void> shutdown() async {
    if (_client != null) {
      await _client!.shutdown();
      _client = null;
      _initialized = false;
    }
  }

  /// Test for WCAG 3.3.2 - Labels or Instructions
  /// 
  /// Validates that all form inputs have proper accessible labels.
  /// Uses advanced validation with proprietary algorithms from yuya-core.
  /// 
  /// ⚠️ Requires tester.runAsync() to work with gRPC:
  /// ```dart
  /// testWidgets('validates form labels', (WidgetTester tester) async {
  ///   await tester.pumpWidget(MyApp());
  ///   
  ///   await tester.runAsync(() async {
  ///     await Yuya.testFormLabels(tester);
  ///   });
  /// });
  /// ```
  /// 
  /// Or initialize a client manually for more control:
  /// ```dart
  /// final client = YuyaGrpcClient();
  /// await client.initialize();
  /// await tester.runAsync(() async {
  ///   final result = await client.checkFormLabels(find);
  ///   expect(result.passed, isTrue);
  /// });
  /// await client.shutdown();
  /// ```
  static Future<void> testFormLabels(WidgetTester tester) async {
    if (!_initialized || _client == null) {
      throw Exception(
        'Yuya not initialized. Call Yuya.initialize() in setUpAll() first.'
      );
    }

    // Use advanced validation with gRPC
    final result = await _client!.checkFormLabels(find);

    // Fail test if validation failed
    if (!result.passed) {
      fail(
        'WCAG 3.3.2 Form Labels validation failed:\n'
        'Total elements checked: ${result.totalElements}\n'
        'Issues found:\n${result.issues.map((i) => '  - $i').join('\n')}',
      );
    }
  }
}
