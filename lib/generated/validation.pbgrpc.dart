//
//  Generated code. Do not modify.
//  source: validation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'validation.pb.dart' as $0;

export 'validation.pb.dart';

@$pb.GrpcServiceName('yuya.ValidationService')
class ValidationServiceClient extends $grpc.Client {
  static final _$validateFormLabels = $grpc.ClientMethod<$0.ValidationRequest, $0.ValidationResponse>(
      '/yuya.ValidationService/ValidateFormLabels',
      ($0.ValidationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidationResponse.fromBuffer(value));
  static final _$healthCheck = $grpc.ClientMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
      '/yuya.ValidationService/HealthCheck',
      ($0.HealthCheckRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HealthCheckResponse.fromBuffer(value));

  ValidationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ValidationResponse> validateFormLabels($0.ValidationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateFormLabels, request, options: options);
  }

  $grpc.ResponseFuture<$0.HealthCheckResponse> healthCheck($0.HealthCheckRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$healthCheck, request, options: options);
  }
}

@$pb.GrpcServiceName('yuya.ValidationService')
abstract class ValidationServiceBase extends $grpc.Service {
  $core.String get $name => 'yuya.ValidationService';

  ValidationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ValidationRequest, $0.ValidationResponse>(
        'ValidateFormLabels',
        validateFormLabels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidationRequest.fromBuffer(value),
        ($0.ValidationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
        'HealthCheck',
        healthCheck_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HealthCheckRequest.fromBuffer(value),
        ($0.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ValidationResponse> validateFormLabels_Pre($grpc.ServiceCall call, $async.Future<$0.ValidationRequest> request) async {
    return validateFormLabels(call, await request);
  }

  $async.Future<$0.HealthCheckResponse> healthCheck_Pre($grpc.ServiceCall call, $async.Future<$0.HealthCheckRequest> request) async {
    return healthCheck(call, await request);
  }

  $async.Future<$0.ValidationResponse> validateFormLabels($grpc.ServiceCall call, $0.ValidationRequest request);
  $async.Future<$0.HealthCheckResponse> healthCheck($grpc.ServiceCall call, $0.HealthCheckRequest request);
}
