/// Yuya Plugin Wrapper
/// This file provides a wrapper around the yuya-core plugin functionality

library;

import 'package:flutter_test/flutter_test.dart';
// Import from yuya-core package which contains the actual test logic
import 'package:yuya_core/yuya_plugin.dart' as core;

/// YuyaPlugin class - provides access to WCAG testing functions
class YuyaPlugin {
  /// Test form labels using WCAG 3.3.2 guidelines
  /// 
  /// This validates that form inputs have proper labels
  /// Throws a test failure if issues are found
  Future<void> checkFormLabels(WidgetTester tester) async {
    await core.Yuya.testFormLabels(tester);
  }
}
