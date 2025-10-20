//
//  Generated code. Do not modify.
//  source: validation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use validationRequestDescriptor instead')
const ValidationRequest$json = {
  '1': 'ValidationRequest',
  '2': [
    {'1': 'text_fields', '3': 1, '4': 3, '5': 11, '6': '.yuya.WidgetData', '10': 'textFields'},
    {'1': 'dropdowns', '3': 2, '4': 3, '5': 11, '6': '.yuya.WidgetData', '10': 'dropdowns'},
  ],
};

/// Descriptor for `ValidationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validationRequestDescriptor = $convert.base64Decode(
    'ChFWYWxpZGF0aW9uUmVxdWVzdBIxCgt0ZXh0X2ZpZWxkcxgBIAMoCzIQLnl1eWEuV2lkZ2V0RG'
    'F0YVIKdGV4dEZpZWxkcxIuCglkcm9wZG93bnMYAiADKAsyEC55dXlhLldpZGdldERhdGFSCWRy'
    'b3Bkb3ducw==');

@$core.Deprecated('Use validationResponseDescriptor instead')
const ValidationResponse$json = {
  '1': 'ValidationResponse',
  '2': [
    {'1': 'passed', '3': 1, '4': 1, '5': 8, '10': 'passed'},
    {'1': 'total_elements', '3': 2, '4': 1, '5': 5, '10': 'totalElements'},
    {'1': 'issues', '3': 3, '4': 3, '5': 9, '10': 'issues'},
  ],
};

/// Descriptor for `ValidationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validationResponseDescriptor = $convert.base64Decode(
    'ChJWYWxpZGF0aW9uUmVzcG9uc2USFgoGcGFzc2VkGAEgASgIUgZwYXNzZWQSJQoOdG90YWxfZW'
    'xlbWVudHMYAiABKAVSDXRvdGFsRWxlbWVudHMSFgoGaXNzdWVzGAMgAygJUgZpc3N1ZXM=');

@$core.Deprecated('Use widgetDataDescriptor instead')
const WidgetData$json = {
  '1': 'WidgetData',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'properties', '3': 2, '4': 3, '5': 11, '6': '.yuya.WidgetData.PropertiesEntry', '10': 'properties'},
  ],
  '3': [WidgetData_PropertiesEntry$json],
};

@$core.Deprecated('Use widgetDataDescriptor instead')
const WidgetData_PropertiesEntry$json = {
  '1': 'PropertiesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WidgetData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List widgetDataDescriptor = $convert.base64Decode(
    'CgpXaWRnZXREYXRhEhIKBHR5cGUYASABKAlSBHR5cGUSQAoKcHJvcGVydGllcxgCIAMoCzIgLn'
    'l1eWEuV2lkZ2V0RGF0YS5Qcm9wZXJ0aWVzRW50cnlSCnByb3BlcnRpZXMaPQoPUHJvcGVydGll'
    'c0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use healthCheckRequestDescriptor instead')
const HealthCheckRequest$json = {
  '1': 'HealthCheckRequest',
};

/// Descriptor for `HealthCheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckRequestDescriptor = $convert.base64Decode(
    'ChJIZWFsdGhDaGVja1JlcXVlc3Q=');

@$core.Deprecated('Use healthCheckResponseDescriptor instead')
const HealthCheckResponse$json = {
  '1': 'HealthCheckResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
    {'1': 'pid', '3': 2, '4': 1, '5': 5, '10': 'pid'},
  ],
};

/// Descriptor for `HealthCheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckResponseDescriptor = $convert.base64Decode(
    'ChNIZWFsdGhDaGVja1Jlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVzEhAKA3BpZBgCIA'
    'EoBVIDcGlk');

