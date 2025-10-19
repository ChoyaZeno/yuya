/// Yuya Test Helpers
/// 
/// Convenience methods for using Yuya in flutter_test environments.
/// These provide a clean, direct API similar to flutter_test matchers.

library;

import 'package:flutter_test/flutter_test.dart';
import 'yuya.dart';
import 'yuya_finder_adapter.dart';

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
  /// Test for WCAG 3.3.2 - Labels or Instructions
  /// 
  /// Validates that all form inputs have proper accessible labels.
  /// Throws a test failure with detailed error messages if issues are found.
  /// 
  /// This method:
  /// 1. Extracts widget data from the widget tree
  /// 2. Sends it to the AOT validation engine
  /// 3. Reports any WCAG compliance issues
  /// 
  /// Example:
  /// ```dart
  /// testWidgets('validates form labels', (WidgetTester tester) async {
  ///   await tester.pumpWidget(
  ///     MaterialApp(
  ///       home: Scaffold(
  ///         body: Column(
  ///           children: [
  ///             TextField(
  ///               decoration: InputDecoration(
  ///                 labelText: 'Email',
  ///                 hintText: 'Enter your email',
  ///               ),
  ///             ),
  ///           ],
  ///         ),
  ///       ),
  ///     ),
  ///   );
  ///   
  ///   // This will pass - TextField has proper labels
  ///   await Yuya.testFormLabels(tester);
  /// });
  /// ```
  static Future<void> testFormLabels(WidgetTester tester) async {
    // Initialize the FFI loader
    final yuya = YuyaFFILoader();
    await yuya.initialize();
    
    // Extract widget data using the adapter pattern
    final finder = FlutterTestFinderAdapter(find);
    final widgetData = YuyaWidgetValidator.extractWidgets(finder);
    
    // Validate using the AOT engine
    final result = yuya.checkFormLabels(widgetData);
    
    // Throw test failure if issues found (flutter_test style)
    if (!result.passed) {
      fail(result.errorMessage);
    }
  }
  
  /// Check form labels without throwing
  /// 
  /// Returns the validation result instead of throwing.
  /// Useful when you want to handle the result yourself.
  /// 
  /// Example:
  /// ```dart
  /// final result = await Yuya.checkFormLabels(tester);
  /// if (!result.passed) {
  ///   print('Issues found: ${result.issues}');
  /// }
  /// ```
  static Future<FormLabelsResult> checkFormLabels(WidgetTester tester) async {
    final yuya = YuyaFFILoader();
    await yuya.initialize();
    
    final finder = FlutterTestFinderAdapter(find);
    final widgetData = YuyaWidgetValidator.extractWidgets(finder);
    
    return yuya.checkFormLabels(widgetData);
  }
}
