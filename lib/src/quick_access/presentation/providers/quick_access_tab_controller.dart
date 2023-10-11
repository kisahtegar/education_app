import 'package:flutter/foundation.dart';

/// QuickAccessTabController is a controller class for managing the current tab
/// index in a quick access navigation system.
///
/// It allows you to keep track of the currently selected tab index and notify
/// listeners when the index changes. This is useful for handling tab-based
/// navigation and updating the UI when the user switches between different
/// tabs.
class QuickAccessTabController extends ChangeNotifier {
  int _currentIndex = 0;

  /// Retrieves the current tab index.
  int get currentIndex => _currentIndex;

  /// Changes the current tab index to the specified [index] and notifies
  /// listeners.
  ///
  /// Use this method to update the current tab index when the user selects a
  /// different tab. It takes an [index] parameter, representing the new tab
  /// index, and then notifies any listeners about the change.
  ///
  /// Example:
  /// ```dart
  /// final tabController = QuickAccessTabController();
  ///
  /// // Change to the second tab (index 1).
  /// tabController.changeIndex(1);
  ///
  /// // Access the updated tab index.
  /// final currentTabIndex = tabController.currentIndex;
  /// print('Current Tab Index: $currentTabIndex'); // Output: Current Tab Index: 1
  /// ```
  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
