/// Yuya - A Friendly WCAG Flutter plugin
library;

import 'yuya_ffi_loader.dart';

// Export the FFI loader
export 'yuya_ffi_loader.dart' show YuyaFFILoader;

/// Yuya - Main class providing easy access to the plugin
class Yuya {
  /// Get a YuyaFFILoader instance
  static YuyaFFILoader get plugin => YuyaFFILoader();
}
