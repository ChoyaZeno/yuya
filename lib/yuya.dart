/// Yuya - A Friendly WCAG Flutter plugin
library;

import 'yuya_ffi_loader.dart';

// Export the FFI loader which contains YuyaPlugin
export 'yuya_ffi_loader.dart' show YuyaPlugin, YuyaFFI;

/// Yuya - Main class providing easy access to the plugin
/// 
/// This is a convenience class that provides a simple way to access
/// the YuyaPlugin without having to instantiate it manually.
class Yuya {
  /// Get a YuyaPlugin instance
  /// 
  /// Returns a new instance of YuyaPlugin ready to use.
  /// The AOT snapshot is bundled with the package and loaded automatically.
  static YuyaPlugin get plugin => YuyaPlugin();
}
