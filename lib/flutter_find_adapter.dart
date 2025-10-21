/// Flutter widget extraction utilities for Yuya gRPC
/// 
/// These utilities extract widget data and send it to yuya-core via gRPC.
/// This file contains ZERO validation logic - only property extraction.

library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper to extract widget properties for gRPC transmission
/// 
/// This is part of the PUBLIC yuya package.
/// Contains NO validation logic - only extracts widget data.
class FlutterWidgetExtractor {
  final CommonFinders _finder;

  FlutterWidgetExtractor(this._finder);

  /// Extract TextField properties for gRPC
  List<Map<String, String?>> extractTextFieldProperties() {
    final textFields = _finder.byType(TextField).evaluate();
    return textFields.map((element) {
      final widget = element.widget as TextField;
      final decoration = widget.decoration;
      
      return {
        'type': 'TextField',
        'labelText': decoration?.labelText,
        'hintText': decoration?.hintText,
        'helperText': decoration?.helperText,
      };
    }).toList();
  }

  /// Extract DropdownButton properties for gRPC
  List<Map<String, String?>> extractDropdownProperties() {
    final dropdowns = _finder.byType(DropdownButton).evaluate();
    return dropdowns.map((element) {
      final widget = element.widget as DropdownButton;
      String? hintText;
      
      if (widget.hint is Text) {
        hintText = (widget.hint as Text).data;
      } else if (widget.hint != null) {
        hintText = 'present';
      }
      
      return {
        'type': 'DropdownButton',
        'hint': hintText,
        'labelText': null,
      };
    }).toList();
  }
}
