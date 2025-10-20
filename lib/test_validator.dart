/// Test-only validator for yuya package
/// 
/// This provides BASIC validation for testing purposes only.
/// It does NOT contain the confidential WCAG validation algorithms.
/// 
/// For production use, the full validation runs in the gRPC service
/// which contains the proprietary algorithms in yuya-core.

library;

import 'generated/validation.pbgrpc.dart' as pb;
import 'yuya_data_structures.dart';

/// Mock validator for testing only
/// 
/// This performs MINIMAL validation just to verify data flow.
/// Real validation logic is in the gRPC service (yuya-core).
class TestValidator {
  /// Basic validation for tests - NOT the real algorithm
  /// 
  /// This only checks if fields exist, not the quality/completeness.
  /// Real WCAG validation happens in yuya-core service.
  static FormLabelsResult validateForTesting(
    List<pb.WidgetData> textFields,
    List<pb.WidgetData> dropdowns,
  ) {
    final issues = <String>[];
    int totalElements = 0;

    // BASIC check - just verify textFields have SOME property
    // (Real algorithm checks quality, length, context, etc.)
    int textFieldIndex = 0;
    for (final widget in textFields) {
      totalElements++;
      
      final hasAnyProperty = widget.properties.isNotEmpty;
      if (!hasAnyProperty) {
        issues.add('TextField #$textFieldIndex - No properties found');
      }
      textFieldIndex++;
    }

    // BASIC check - just verify dropdowns have SOME property
    // (Real algorithm checks accessibility, context, etc.)
    int dropdownIndex = 0;
    for (final widget in dropdowns) {
      totalElements++;
      
      final hasAnyProperty = widget.properties.isNotEmpty;
      if (!hasAnyProperty) {
        issues.add('Dropdown #$dropdownIndex - No properties found');
      }
      dropdownIndex++;
    }

    return FormLabelsResult(
      passed: issues.isEmpty,
      totalElements: totalElements,
      issues: issues,
    );
  }
}
