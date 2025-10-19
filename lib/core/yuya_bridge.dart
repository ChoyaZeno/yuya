/// Bridge Helper - Direct widget validation with FFI
/// No WidgetData serialization needed - works directly with Material 3 widgets!
/// 
/// Architecture:
/// - Public package provides callbacks to find widgets
/// - yuya-core validates directly by calling back to query properties
/// - No intermediate DTOs, no JSON, pure Dart-to-Dart calls!

library;

import 'package:flutter/material.dart';
import '../yuya_data_structures.dart';

/// Callback: Find all widgets of a specific type
typedef FindWidgetsByType<T> = Iterable<T> Function();

/// Callback: Find widgets by predicate (for generic types like DropdownButton<T>)
typedef FindWidgetsByPredicate = Iterable<Widget> Function();

class YuyaBridge {
  /// Validate form labels directly - NO WidgetData serialization!
  /// 
  /// We work directly with Material 3 widgets via callbacks.
  /// The validation logic calls back to check properties in real-time.
  static FormLabelsResult validateFormLabels({
    required FindWidgetsByType<TextField> findTextFields,
    required FindWidgetsByPredicate findDropdowns, // Use predicate for generic types
  }) {
    final issues = <String>[];
    int totalElements = 0;

    // Validate TextFields directly
    final textFields = findTextFields();
    int textFieldIndex = 0;
    for (final widget in textFields) {
      totalElements++;
      final decoration = widget.decoration;
      
      // Check if TextField has ANY accessible label
      final hasLabel = decoration?.labelText != null ||
                      decoration?.hintText != null ||
                      decoration?.helperText != null;
      
      if (!hasLabel) {
        issues.add('TextField #$textFieldIndex - Missing accessible label');
      }
      textFieldIndex++;
    }

    // Validate DropdownButtons directly (handles any generic type)
    final dropdowns = findDropdowns();
    int dropdownIndex = 0;
    for (final widget in dropdowns) {
      totalElements++;
      
      // Cast to dynamic to access properties
      final dropdown = widget as dynamic;
      
      // Check if DropdownButton has hint or value
      final hasHint = dropdown.hint != null;
      final hasValue = dropdown.value != null;
      
      if (!hasHint && !hasValue) {
        issues.add('DropdownButton #$dropdownIndex - Missing hint or value');
      }
      dropdownIndex++;
    }

    return FormLabelsResult(
      passed: issues.isEmpty,
      issues: issues,
      totalElements: totalElements,
    );
  }

}


