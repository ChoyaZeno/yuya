/// FFI Loader for Yuya Plugin
/// This file loads the compiled AOT snapshot and provides access to native functions
library;

import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:isolate';

typedef NativeFormLabelsFunc = ffi.Void Function();
typedef DartFormLabelsFunc = void Function();

/// YuyaFFI class to load and interact with the AOT-compiled plugin
class YuyaFFI {
  static YuyaFFI? _instance;
  bool _isLoaded = false;

  YuyaFFI._();

  /// Get singleton instance
  static YuyaFFI get instance {
    _instance ??= YuyaFFI._();
    return _instance!;
  }

  /// Initialize the FFI loader with the AOT snapshot path
  /// Note: AOT snapshots work differently - they need to be loaded via Isolate.spawnUri
  /// This is a placeholder for demonstration. For production, you'd typically
  /// compile to native shared library (.so, .dylib, .dll) instead of AOT snapshot
  Future<void> initialize(String aotSnapshotPath) async {
    if (_isLoaded) return;

    // Note: Direct FFI loading of AOT snapshots is not the typical pattern
    // This demonstrates the structure. For real FFI, you'd compile to native lib
    print('Initializing Yuya FFI with AOT snapshot: $aotSnapshotPath');

    // Verify the AOT snapshot exists
    final file = File(aotSnapshotPath);
    if (!await file.exists()) {
      throw Exception('AOT snapshot not found at: $aotSnapshotPath');
    }

    _isLoaded = true;
    print('Yuya FFI initialized successfully');
  }

  /// Execute function via spawned isolate from AOT snapshot
  Future<R> executeInAOT<R>(
    String aotSnapshotPath,
    R Function(dynamic) handler,
  ) async {
    final receivePort = ReceivePort();

    try {
      // Spawn isolate from AOT snapshot
      await Isolate.spawnUri(
        Uri.file(aotSnapshotPath),
        [],
        receivePort.sendPort,
      );

      // Wait for response
      final response = await receivePort.first;
      return handler(response);
    } finally {
      receivePort.close();
    }
  }

  /// Check if FFI is loaded
  bool get isLoaded => _isLoaded;
}

/// High-level API for the AOT plugin
class YuyaPlugin {
  final YuyaFFI _ffi = YuyaFFI.instance;

  /// Initialize the plugin with AOT snapshot path
  Future<void> initialize(String aotSnapshotPath) async {
    await _ffi.initialize(aotSnapshotPath);
  }

  void checkFormLabels(int value) {
    if (!_ffi.isLoaded) {
      throw Exception('Plugin not initialized. Call initialize() first.');
    }
  }
}
