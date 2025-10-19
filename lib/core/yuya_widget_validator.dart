/// Yuya Widget Validator - Core validation logic using abstract finders
/// 
/// This module contains the core validation logic that works with
/// abstract widget finders, allowing it to be independent of flutter_test.

library;

import 'package:flutter/material.dart';
import 'yuya_finder_interface.dart';
import 'yuya_data_structures.dart' show WidgetData;

/// Core widget validator that uses abstract finders
/// 
/// This class extracts widget data using the abstract IWidgetFinder interface,
/// making it independent of flutter_test while still able to work with
/// widget trees.
class YuyaWidgetValidator {
  /// Extract widget data from a widget tree using the provided finder
  /// 
  /// This method uses the abstract IWidgetFinder to locate and extract
  /// accessibility data from TextField and DropdownButton widgets.
  /// 
  /// Example usage in the public package:
  /// ```dart
  /// final finder = FlutterTestFinderAdapter(find); // Implements IWidgetFinder
  /// final widgetData = YuyaWidgetValidator.extractWidgets(finder);
  /// ```
  static List<WidgetData> extractWidgets(IWidgetFinder finder) {
    final widgetDataList = <WidgetData>[];
    int textFieldIndex = 0;
    int dropdownIndex = 0;

    // Extract TextField data
    final textFields = finder.byType(TextField);
    for (final element in textFields.evaluate()) {
      final widget = element.widget;
      if (widget is TextField) {
        final decoration = widget.decoration;

        widgetDataList.add(WidgetData(
          type: 'TextField',
          index: textFieldIndex++,
          labelText: decoration?.labelText,
          hintText: decoration?.hintText,
          helperText: decoration?.helperText,
        ));
      }
    }

    // Extract DropdownButton data
    final dropdowns = finder.byType(DropdownButton);
    for (final element in dropdowns.evaluate()) {
      final widget = element.widget;
      if (widget is DropdownButton) {
        String? hintText;
        if (widget.hint is Text) {
          hintText = (widget.hint as Text).data ??
              (widget.hint as Text).textSpan?.toPlainText();
        }

        widgetDataList.add(WidgetData(
          type: 'DropdownButton',
          index: dropdownIndex++,
          hintText: hintText,
          hasValue: widget.value != null,
        ));
      }
    }

    return widgetDataList;
  }

  /// Extract widgets from an element tree visitor pattern
  /// 
  /// This method traverses an element tree and extracts widget data.
  /// Useful for runtime validation without WidgetTester.
  static List<WidgetData> extractFromElement(IWidgetElement rootElement) {
    final widgetDataList = <WidgetData>[];
    int textFieldIndex = 0;
    int dropdownIndex = 0;

    void visitElement(IWidgetElement element) {
      final widget = element.widget;

      // Check for TextField
      if (widget is TextField) {
        final decoration = widget.decoration;
        widgetDataList.add(WidgetData(
          type: 'TextField',
          index: textFieldIndex++,
          labelText: decoration?.labelText,
          hintText: decoration?.hintText,
          helperText: decoration?.helperText,
        ));
      }

      // Check for DropdownButton
      if (widget is DropdownButton) {
        String? hintText;
        if (widget.hint is Text) {
          hintText = (widget.hint as Text).data ??
              (widget.hint as Text).textSpan?.toPlainText();
        }

        widgetDataList.add(WidgetData(
          type: 'DropdownButton',
          index: dropdownIndex++,
          hintText: hintText,
          hasValue: widget.value != null,
        ));
      }

      // Visit children
      element.visitChildren(visitElement);
    }

    rootElement.visitChildren(visitElement);
    return widgetDataList;
  }
}
