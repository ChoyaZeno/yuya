/// Yuya Finder Adapter - Bridges flutter_test's CommonFinders to abstract interfaces
/// 
/// This adapter implements the abstract IWidgetFinder interfaces
/// using flutter_test's actual finder implementation.

library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'core/yuya_finder_interface.dart';

/// Adapter that wraps flutter_test's CommonFinders to implement IWidgetFinder
/// 
/// This class bridges flutter_test's CommonFinders to the abstract
/// IWidgetFinder interface, allowing the core validation logic to work
/// with actual widget trees in tests.
/// 
/// Example:
/// ```dart
/// testWidgets('validate form', (WidgetTester tester) async {
///   await tester.pumpWidget(MyFormWidget());
///   
///   final finder = FlutterTestFinderAdapter(find);
///   final widgetData = YuyaWidgetValidator.extractWidgets(finder);
///   
///   final yuya = YuyaFFILoader();
///   await yuya.initialize();
///   final result = yuya.checkFormLabels(widgetData);
///   
///   expect(result.passed, isTrue);
/// });
/// ```
class FlutterTestFinderAdapter implements IWidgetFinder {
  final CommonFinders _commonFinders;

  FlutterTestFinderAdapter(this._commonFinders);

  @override
  IFinderResult byType(Type type) {
    return FlutterTestFinderResult(_commonFinders.byType(type));
  }

  @override
  IFinderResult all() {
    return FlutterTestFinderResult(_commonFinders.byElementPredicate((_) => true));
  }
}

/// Adapter for finder results
class FlutterTestFinderResult implements IFinderResult {
  final Finder _finder;

  FlutterTestFinderResult(this._finder);

  @override
  Iterable<IWidgetElement> evaluate() {
    return _finder.evaluate().map((e) => FlutterTestWidgetElement(e));
  }

  @override
  int get found => _finder.evaluate().length;
}

/// Adapter for widget elements
class FlutterTestWidgetElement implements IWidgetElement {
  final Element _element;

  FlutterTestWidgetElement(this._element);

  @override
  Object get widget => _element.widget;

  @override
  void visitChildren(void Function(IWidgetElement element) visitor) {
    _element.visitChildren((child) {
      visitor(FlutterTestWidgetElement(child));
    });
  }
}
