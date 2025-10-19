/// Data structures for Yuya WCAG validation
/// Simple DTOs - no business logic

class FormLabelsResult {
  final bool passed;
  final List<String> issues;
  final int totalElements;

  const FormLabelsResult({
    required this.passed,
    required this.issues,
    required this.totalElements,
  });

  String get errorMessage {
    if (passed) return '';
    
    return '''WCAG 3.3.2 Form Labels Issues Found:

${issues.map((e) => '• $e').join('\n')}

Summary: Tested $totalElements form elements

Recommendations:
• Add labelText to InputDecoration for clear field identification
• Use hintText to provide input format examples
• Add helperText for additional instructions when needed
• Ensure label text is descriptive and meaningful
• Consider using Semantics widget for complex form layouts
• Test with screen readers to verify label announcements''';
  }
  
  Map<String, dynamic> toJson() => {
    'passed': passed,
    'issues': issues,
    'totalElements': totalElements,
    'errorMessage': errorMessage,
  };
  
  factory FormLabelsResult.fromJson(Map<String, dynamic> json) => FormLabelsResult(
    passed: json['passed'] as bool,
    issues: List<String>.from(json['issues'] as List),
    totalElements: json['totalElements'] as int,
  );
}

class WidgetData {
  final String type;
  final int index;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool? hasValue;
  
  const WidgetData({
    required this.type,
    required this.index,
    this.labelText,
    this.hintText,
    this.helperText,
    this.hasValue,
  });
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'index': index,
    'labelText': labelText,
    'hintText': hintText,
    'helperText': helperText,
    'hasValue': hasValue,
  };
  
  factory WidgetData.fromJson(Map<String, dynamic> json) => WidgetData(
    type: json['type'] as String,
    index: json['index'] as int,
    labelText: json['labelText'] as String?,
    hintText: json['hintText'] as String?,
    helperText: json['helperText'] as String?,
    hasValue: json['hasValue'] as bool?,
  );
}
