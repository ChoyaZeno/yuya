/// Abstract Widget Finder Interface
/// 
/// This interface abstracts the widget finding functionality,
/// allowing yuya-core to work with finders without depending on flutter_test.
/// The public package implements this interface using actual CommonFinders.

library;

/// Abstract interface for finding widgets in a widget tree
/// 
/// This mirrors the CommonFinders API from flutter_test but as an abstraction.
/// The public package will implement this using the actual `find` object.
abstract class IWidgetFinder {
  /// Finds widgets by their runtime type.
  /// 
  /// Example: `findByType<TextField>()` or `findByType(TextField)`
  IFinderResult byType(Type type);
  
  /// Finds all widgets in the tree.
  IFinderResult all();
}

/// Result of a widget finder operation
/// 
/// This represents the result of a find operation, containing the matched elements.
abstract class IFinderResult {
  /// Evaluates the finder and returns an iterable of elements
  Iterable<IWidgetElement> evaluate();
  
  /// Returns the number of widgets found
  int get found;
}

/// Abstract representation of a widget element
/// 
/// This provides access to the widget instance and its properties
/// without depending on flutter_test's Element type.
abstract class IWidgetElement {
  /// The widget instance
  Object get widget;
  
  /// Visit all child elements
  void visitChildren(void Function(IWidgetElement element) visitor);
}
