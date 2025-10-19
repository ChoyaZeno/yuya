/// Yuya Widget Extractor - DEPRECATED
/// 
/// This file is DEPRECATED in favor of using YuyaWidgetValidator
/// with FlutterTestFinderAdapter.
/// 
/// **Old API (deprecated):**
/// ```dart
/// final widgetData = YuyaWidgetExtractor.extractFromTester(tester);
/// // or
/// final widgetData = tester.extractYuyaWidgetData();
/// ```
/// 
/// **New API (recommended):**
/// ```dart
/// final finder = FlutterTestFinderAdapter(find);
/// final widgetData = YuyaWidgetValidator.extractWidgets(finder);
/// ```

@Deprecated('Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead')
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'core/yuya_data_structures.dart' show WidgetData;
import 'core/yuya_widget_validator.dart';
import 'yuya_finder_adapter.dart';

/// Helper class for extracting widget data from WidgetTester
/// 
/// @deprecated Use [YuyaWidgetValidator.extractWidgets] with [FlutterTestFinderAdapter] instead.
@Deprecated('Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead')
class YuyaWidgetExtractor {
  /// Extract widget data from a WidgetTester for WCAG validation
  /// 
  /// @deprecated Use [YuyaWidgetValidator.extractWidgets] with [FlutterTestFinderAdapter] instead.
  /// 
  /// Migration:
  /// ```dart
  /// // Old
  /// final widgetData = YuyaWidgetExtractor.extractFromTester(tester);
  /// 
  /// // New
  /// final finder = FlutterTestFinderAdapter(find);
  /// final widgetData = YuyaWidgetValidator.extractWidgets(finder);
  /// ```
  @Deprecated('Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead')
  static List<WidgetData> extractFromTester(WidgetTester tester) {
    final finder = FlutterTestFinderAdapter(find);
    return YuyaWidgetValidator.extractWidgets(finder);
  }

  /// Extract widget data from a generic widget tree using Element
  /// 
  /// @deprecated Use [YuyaWidgetValidator.extractFromElement] with [FlutterTestWidgetElement] instead.
  @Deprecated('Use YuyaWidgetValidator.extractFromElement(FlutterTestWidgetElement(element)) instead')
  static List<WidgetData> extractFromElement(Element element) {
    final wrappedElement = FlutterTestWidgetElement(element);
    return YuyaWidgetValidator.extractFromElement(wrappedElement);
  }
}

/// Extension methods for convenience when working with WidgetTester
/// 
/// @deprecated Use [YuyaWidgetValidator.extractWidgets] with [FlutterTestFinderAdapter] instead.
@Deprecated('Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead')
extension YuyaWidgetTesterExtension on WidgetTester {
  /// Extract widget data from this WidgetTester for WCAG validation
  /// 
  /// @deprecated Use [YuyaWidgetValidator.extractWidgets] with [FlutterTestFinderAdapter] instead.
  /// 
  /// Migration:
  /// ```dart
  /// // Old
  /// final widgetData = tester.extractYuyaWidgetData();
  /// 
  /// // New
  /// final finder = FlutterTestFinderAdapter(find);
  /// final widgetData = YuyaWidgetValidator.extractWidgets(finder);
  /// ```
  @Deprecated('Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead')
  List<WidgetData> extractYuyaWidgetData() {
    final finder = FlutterTestFinderAdapter(find);
    return YuyaWidgetValidator.extractWidgets(finder);
  }
}
