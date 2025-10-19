/// Data structure for widget information extracted from Flutter tests
/// This is the only data structure shared between the public and private repos
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
