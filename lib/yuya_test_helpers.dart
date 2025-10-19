/// Yuya Test Helpers
/// 
/// Convenience methods for using Yuya in flutter_test environments.
/// These provide a clean, direct API similar to flutter_test matchers.

library;

import 'package:flutter_test/flutter_test.dart';
import 'yuya.dart';

import 'yuya_data_structures.dart';
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
    final yuya = YuyaFFILoader();
    
    // Pass find directly - extraction happens internally
    final result = yuya.checkFormLabels(find);
    
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
    
    return yuya.checkFormLabels(find);
  }
}
