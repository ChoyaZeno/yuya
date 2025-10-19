/// Yuya - WCAG Form Validation Package
/// 
/// Public API for WCAG accessibility validation using AOT-compiled engine.
/// 
/// Self-contained package with copied core files (no external dependencies).

library yuya;

// Core FFI loader (no flutter_test dependency)
// Executes the AOT binary for WCAG validation
export 'yuya_ffi_loader.dart' show YuyaFFILoader, FormLabelsResult;

// Finder adapter - Implements abstract interfaces
// using flutter_test's CommonFinders
export 'yuya_finder_adapter.dart' 
    show FlutterTestFinderAdapter, FlutterTestFinderResult, FlutterTestWidgetElement;

// Core files (copied from yuya-core during deployment)
// ONLY abstract interfaces and data structures - NO business logic!
export 'core/yuya_finder_interface.dart' 
    show IWidgetFinder, IFinderResult, IWidgetElement;

export 'core/yuya_widget_validator.dart' 
    show YuyaWidgetValidator;

export 'core/yuya_data_structures.dart' 
    show WidgetData;

// Deprecated: Old widget extractor (for backward compatibility)
// Use YuyaWidgetValidator.extractWidgets(FlutterTestFinderAdapter(find)) instead
export 'yuya_widget_extractor.dart';
