/// Yuya Data Structures
/// 
/// This file contains ONLY the data structures needed for communication
/// between the public package and the AOT binary.
/// 
/// NO BUSINESS LOGIC - all validation algorithms are in the compiled AOT binary.

library;

/// Widget data passed to the AOT validation engine
/// 
/// This is a simple data transfer object (DTO) with no logic.
class WidgetData {
  final String type; // 'TextField' or 'DropdownButton'
  final int index;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final bool? hasValue; // For dropdowns
  
  const WidgetData({
    required this.type,
    required this.index,
    this.labelText,
    this.hintText,
    this.helperText,
    this.hasValue,
  });
  
  /// Serialize to JSON for sending to AOT binary
  Map<String, dynamic> toJson() => {
    'type': type,
    'index': index,
    'labelText': labelText,
    'hintText': hintText,
    'helperText': helperText,
    'hasValue': hasValue,
  };
  
  /// Deserialize from JSON (if needed)
  factory WidgetData.fromJson(Map<String, dynamic> json) => WidgetData(
    type: json['type'] as String,
    index: json['index'] as int,
    labelText: json['labelText'] as String?,
    hintText: json['hintText'] as String?,
    helperText: json['helperText'] as String?,
    hasValue: json['hasValue'] as bool?,
  );
}
