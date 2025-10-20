/// Yuya gRPC Client
/// 
/// Connects to the gRPC validation service with strong typing.
/// Uses dart run to execute the service from yuya-core source.

library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'generated/validation.pbgrpc.dart' as pb;
import 'yuya_data_structures.dart' hide WidgetData;

const int kGrpcPort = 50051;
const String kGrpcHost = 'localhost';

class YuyaGrpcClient {
  String? _coreDirectory;
  String? _serviceSourcePath;
  Process? _serviceProcess;
  ClientChannel? _channel;
  pb.ValidationServiceClient? _client;
  bool _ownsProcess = false;

  /// Initialize and find the yuya-core service
  Future<void> initialize() async {
    // Find yuya-core source directory
    final possiblePaths = [
      '/Users/damienrietdijk/Git/yuya-core',
      '../yuya-core',
      '../../yuya-core',
    ];

    for (final p in possiblePaths) {
      final dir = Directory(p);
      final serviceFile = File('$p/lib/yuya_grpc_service.dart');
      if (await dir.exists() && await serviceFile.exists()) {
        _coreDirectory = dir.absolute.path;
        _serviceSourcePath = serviceFile.absolute.path;
        break;
      }
    }

    if (_coreDirectory == null || _serviceSourcePath == null) {
      throw Exception('yuya-core service source not found in: $possiblePaths');
    }

    // Start service and connect
    await _ensureServiceRunning();
  }

  /// Ensure the gRPC service is running and connected
  Future<void> _ensureServiceRunning() async {
    // Try to connect to existing service
    if (await _tryConnect()) {
      _ownsProcess = false; // Using existing service
      return;
    }

    // Start service using dart run
    _serviceProcess = await Process.start(
      'dart',
      ['run', _serviceSourcePath!],
      workingDirectory: _coreDirectory,
      mode: ProcessStartMode.normal,
    );
    _ownsProcess = true;

    // Consume stdout/stderr and log for debugging
    _serviceProcess!.stdout.listen((data) {
      final msg = String.fromCharCodes(data).trim();
      if (msg.isNotEmpty) print('[Service] $msg');
    });
    _serviceProcess!.stderr.listen((data) {
      final msg = String.fromCharCodes(data).trim();
      if (msg.isNotEmpty) print('[Service ERROR] $msg');
    });

    // Wait for service to be ready (longer timeout for slow starts)
    for (int i = 0; i < 100; i++) {
      await Future.delayed(Duration(milliseconds: 200));
      if (await _tryConnect()) {
        return;
      }
    }

    // Try to get more info about what went wrong
    String processInfo = 'unknown';
    if (_serviceProcess != null) {
      processInfo = 'PID ${_serviceProcess!.pid}, exitCode: ${_serviceProcess!.exitCode}';
    }
    
    throw Exception('Failed to connect to gRPC service within 20 seconds. Process: $processInfo');
  }

  /// Try to connect to the gRPC service
  Future<bool> _tryConnect() async {
    try {
      if (_channel == null) {
        _channel = ClientChannel(
          kGrpcHost,
          port: kGrpcPort,
          options: ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );
        _client = pb.ValidationServiceClient(_channel!);
      }

      // Try a health check
      await _client!.healthCheck(
        pb.HealthCheckRequest(),
        options: CallOptions(timeout: Duration(milliseconds: 500)),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check form labels for WCAG compliance using advanced validation
  /// 
  /// Uses yuya-core's proprietary validation service with:
  /// - Label quality scoring (length, meaningfulness)
  /// - Generic label detection ("text", "input" → rejected)
  /// - Context-aware validation  
  /// - Advanced heuristics
  /// - Detailed recommendations
  /// 
  /// ⚠️ When using with testWidgets(), wrap the call in tester.runAsync():
  /// ```dart
  /// await tester.runAsync(() async {
  ///   final result = await client.checkFormLabels(find);
  ///   expect(result.passed, isTrue);
  /// });
  /// ```
  Future<FormLabelsResult> checkFormLabels(CommonFinders find) async {
    if (_client == null) {
      throw Exception('Not initialized. Call initialize() first.');
    }

    // Extract widget data with strong types
    final request = pb.ValidationRequest()
      ..textFields.addAll(_extractTextFields(find))
      ..dropdowns.addAll(_extractDropdowns(find));

    // Send gRPC request to advanced validation service
    try {
      final response = await _client!.validateFormLabels(request);

      return FormLabelsResult(
        passed: response.passed,
        totalElements: response.totalElements,
        issues: response.issues.toList(),
      );
    } catch (e) {
      throw Exception('gRPC call failed: $e');
    }
  }

  /// Extract TextField widgets as strongly-typed WidgetData
  List<pb.WidgetData> _extractTextFields(CommonFinders find) {
    final widgets = find.byType(TextField).evaluate();
    final result = <pb.WidgetData>[];

    for (final element in widgets) {
      final widget = element.widget as TextField;
      final decoration = widget.decoration;

      final widgetData = pb.WidgetData()
        ..type = 'TextField';

      if (decoration?.labelText != null) {
        widgetData.properties['labelText'] = decoration!.labelText!;
      }
      if (decoration?.hintText != null) {
        widgetData.properties['hintText'] = decoration!.hintText!;
      }
      if (widget.controller?.text != null) {
        widgetData.properties['text'] = widget.controller!.text;
      }

      result.add(widgetData);
    }

    return result;
  }

  /// Extract Dropdown widgets as strongly-typed WidgetData
  List<pb.WidgetData> _extractDropdowns(CommonFinders find) {
    final widgets = find.byWidgetPredicate(
      (widget) => widget.runtimeType.toString().startsWith('DropdownButton'),
    ).evaluate();
    
    final result = <pb.WidgetData>[];

    for (final element in widgets) {
      final widget = element.widget as dynamic; // Cast to dynamic for property access
      final widgetData = pb.WidgetData()
        ..type = 'DropdownButton';

      try {
        // Try to access hint property directly (works because of dynamic)
        final hint = widget.hint;
        if (hint != null) {
          widgetData.properties['hint'] = 'present';
        }
      } catch (e) {
        // Hint property doesn't exist or couldn't be accessed
      }

      result.add(widgetData);
    }

    return result;
  }

  /// Shutdown the service and close connections
  Future<void> shutdown() async {
    // Close channel
    await _channel?.shutdown();
    _channel = null;
    _client = null;
    
    // Kill process if we own it
    if (_ownsProcess && _serviceProcess != null) {
      _serviceProcess!.kill(ProcessSignal.sigterm);
      
      // Wait for process to exit (with timeout)
      try {
        await _serviceProcess!.exitCode.timeout(Duration(seconds: 2));
      } catch (_) {
        // Force kill if it doesn't exit gracefully
        _serviceProcess!.kill(ProcessSignal.sigkill);
      }
      
      _serviceProcess = null;
      _ownsProcess = false;
    }
  }
}
