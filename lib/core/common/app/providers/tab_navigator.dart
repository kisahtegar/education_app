import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Manage the navigation stack for a tab-based or multi-screen application. It
/// provides methods to push, pop, and manipulate the navigation stack, allowing
/// you to control the navigation flow within your app. This class can be
/// integrated with your user interface to enable seamless navigation between
/// different screens or tabs.
class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigationStack.add(_initialPage);
  }

  final TabItem _initialPage;
  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  /// This used to add a new page (represented by a `TabItem`) to the navigation
  /// stack.
  void push(TabItem page) {
    _navigationStack.add(page);
    notifyListeners();
  }

  /// This used to remove the most recent page (represented by a `TabItem`) from
  ///
  /// the navigation stack, effectively navigating back to the previous page.
  void pop() {
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  /// This used to close all navigation stacks and return to the `root page` in
  /// your custom tab navigation.
  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }

  /// This used to remove a specific page (represented by a `TabItem`) from the
  /// navigation stack.
  void popTo(TabItem page) {
    _navigationStack.remove(page);
    notifyListeners();
  }

  /// This is used to `pop (remove)` pages from the navigation stack until a,
  ///
  /// specific page (represented by a `TabItem`) is reached.
  void popUntil(TabItem? page) {
    if (page == null) return popToRoot();
    if (_navigationStack.length > 1) {
      _navigationStack.removeRange(1, _navigationStack.indexOf(page) + 1);
      notifyListeners();
    }
  }

  /// This used to close all stack/pop, and add new specific page.
  void pushAndRemoveUntil(TabItem page) {
    _navigationStack
      ..clear()
      ..add(page);
    notifyListeners();
  }
}

/// The `TabNavigatorProvider` class is an `InheritedNotifier` widget that serve
/// as a means to provide the `TabNavigator` instance to the widget tree and
/// allow widgets within the tree to access it.
///
/// This is a common pattern in Flutter for sharing data or state across
/// different parts of your application without having to pass it explicitly
/// through constructor parameters.
class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

/// `TabItem` is a class that represents an item or page within your custom tab
/// navigation system. It is used to `encapsulate` the `content` and `identity`
/// of each tab or page.
class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<dynamic> get props => [id];
}
