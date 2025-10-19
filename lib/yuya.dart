/// Yuya - WCAG Form Validation Package
/// 
/// Public API for WCAG accessibility validation using AOT-compiled engine.
/// 
/// Self-contained package with no external dependencies.

library yuya;

// Core FFI loader - Executes AOT binary for WCAG validation
export 'yuya_ffi_loader.dart' show YuyaFFILoader, FormLabelsResult;

// Data structures - Simple DTOs
export 'yuya_data_structures.dart' show WidgetData;

// Test helpers - Clean API for flutter_test
// Provides simple test methods like Yuya.testFormLabels(tester)
export 'yuya_test_helpers.dart' show Yuya;
