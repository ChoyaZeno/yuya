//
//  Generated code. Do not modify.
//  source: validation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Request to validate widgets
class ValidationRequest extends $pb.GeneratedMessage {
  factory ValidationRequest({
    $core.Iterable<WidgetData>? textFields,
    $core.Iterable<WidgetData>? dropdowns,
  }) {
    final $result = create();
    if (textFields != null) {
      $result.textFields.addAll(textFields);
    }
    if (dropdowns != null) {
      $result.dropdowns.addAll(dropdowns);
    }
    return $result;
  }
  ValidationRequest._() : super();
  factory ValidationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'yuya'), createEmptyInstance: create)
    ..pc<WidgetData>(1, _omitFieldNames ? '' : 'textFields', $pb.PbFieldType.PM, subBuilder: WidgetData.create)
    ..pc<WidgetData>(2, _omitFieldNames ? '' : 'dropdowns', $pb.PbFieldType.PM, subBuilder: WidgetData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidationRequest clone() => ValidationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidationRequest copyWith(void Function(ValidationRequest) updates) => super.copyWith((message) => updates(message as ValidationRequest)) as ValidationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidationRequest create() => ValidationRequest._();
  ValidationRequest createEmptyInstance() => create();
  static $pb.PbList<ValidationRequest> createRepeated() => $pb.PbList<ValidationRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidationRequest>(create);
  static ValidationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WidgetData> get textFields => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<WidgetData> get dropdowns => $_getList(1);
}

/// Response with validation results
class ValidationResponse extends $pb.GeneratedMessage {
  factory ValidationResponse({
    $core.bool? passed,
    $core.int? totalElements,
    $core.Iterable<$core.String>? issues,
  }) {
    final $result = create();
    if (passed != null) {
      $result.passed = passed;
    }
    if (totalElements != null) {
      $result.totalElements = totalElements;
    }
    if (issues != null) {
      $result.issues.addAll(issues);
    }
    return $result;
  }
  ValidationResponse._() : super();
  factory ValidationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'yuya'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'passed')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalElements', $pb.PbFieldType.O3)
    ..pPS(3, _omitFieldNames ? '' : 'issues')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidationResponse clone() => ValidationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidationResponse copyWith(void Function(ValidationResponse) updates) => super.copyWith((message) => updates(message as ValidationResponse)) as ValidationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidationResponse create() => ValidationResponse._();
  ValidationResponse createEmptyInstance() => create();
  static $pb.PbList<ValidationResponse> createRepeated() => $pb.PbList<ValidationResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidationResponse>(create);
  static ValidationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get passed => $_getBF(0);
  @$pb.TagNumber(1)
  set passed($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPassed() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassed() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalElements => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalElements($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalElements() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalElements() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get issues => $_getList(2);
}

/// Widget data with properties
class WidgetData extends $pb.GeneratedMessage {
  factory WidgetData({
    $core.String? type,
    $core.Map<$core.String, $core.String>? properties,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (properties != null) {
      $result.properties.addAll(properties);
    }
    return $result;
  }
  WidgetData._() : super();
  factory WidgetData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WidgetData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WidgetData', package: const $pb.PackageName(_omitMessageNames ? '' : 'yuya'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'properties', entryClassName: 'WidgetData.PropertiesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('yuya'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WidgetData clone() => WidgetData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WidgetData copyWith(void Function(WidgetData) updates) => super.copyWith((message) => updates(message as WidgetData)) as WidgetData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WidgetData create() => WidgetData._();
  WidgetData createEmptyInstance() => create();
  static $pb.PbList<WidgetData> createRepeated() => $pb.PbList<WidgetData>();
  @$core.pragma('dart2js:noInline')
  static WidgetData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WidgetData>(create);
  static WidgetData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get properties => $_getMap(1);
}

/// Health check messages
class HealthCheckRequest extends $pb.GeneratedMessage {
  factory HealthCheckRequest() => create();
  HealthCheckRequest._() : super();
  factory HealthCheckRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthCheckRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HealthCheckRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'yuya'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HealthCheckRequest clone() => HealthCheckRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HealthCheckRequest copyWith(void Function(HealthCheckRequest) updates) => super.copyWith((message) => updates(message as HealthCheckRequest)) as HealthCheckRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest create() => HealthCheckRequest._();
  HealthCheckRequest createEmptyInstance() => create();
  static $pb.PbList<HealthCheckRequest> createRepeated() => $pb.PbList<HealthCheckRequest>();
  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthCheckRequest>(create);
  static HealthCheckRequest? _defaultInstance;
}

class HealthCheckResponse extends $pb.GeneratedMessage {
  factory HealthCheckResponse({
    $core.String? status,
    $core.int? pid,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (pid != null) {
      $result.pid = pid;
    }
    return $result;
  }
  HealthCheckResponse._() : super();
  factory HealthCheckResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HealthCheckResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HealthCheckResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'yuya'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pid', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HealthCheckResponse clone() => HealthCheckResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HealthCheckResponse copyWith(void Function(HealthCheckResponse) updates) => super.copyWith((message) => updates(message as HealthCheckResponse)) as HealthCheckResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse create() => HealthCheckResponse._();
  HealthCheckResponse createEmptyInstance() => create();
  static $pb.PbList<HealthCheckResponse> createRepeated() => $pb.PbList<HealthCheckResponse>();
  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HealthCheckResponse>(create);
  static HealthCheckResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pid => $_getIZ(1);
  @$pb.TagNumber(2)
  set pid($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPid() => $_has(1);
  @$pb.TagNumber(2)
  void clearPid() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
