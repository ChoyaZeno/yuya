/// Yuya FFI Loader - Direct Bridge Pattern (NO AOT, NO JSON, NO WidgetData!)
/// 
/// Architecture:
/// - Public package calls yuya-core bridge directly
/// - Bridge validates widgets in real-time via callbacks
/// - NO serialization, NO process calls, just pure Dart!

library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'yuya_data_structures.dart';
import 'core/yuya_bridge.dart';

/// FFI Loader for Yuya WCAG validation
class YuyaFFILoader {
  /// Check form labels for WCAG compliance
  /// 
  /// Simple! Just call the bridge directly with finder callbacks.
  FormLabelsResult checkFormLabels(CommonFinders find) {
    // Provide callbacks to find widgets
    Iterable<TextField> findTextFields() {
      return find.byType(TextField).evaluate().map((e) => e.widget as TextField);
    }

    Iterable<Widget> findDropdowns() {
      // Use predicate to match any DropdownButton<T> regardless of generic type
      return find.byWidgetPredicate((widget) => 
        widget.runtimeType.toString().startsWith('DropdownButton')
      ).evaluate().map((e) => e.widget);
    }

    // Bridge does ALL the validation directly!
    return YuyaBridge.validateFormLabels(
      findTextFields: findTextFields,
      findDropdowns: findDropdowns,
    );
  }
}
