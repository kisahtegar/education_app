// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/views/persistent_view.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/home/presentation/views/home_view.dart';
import 'package:education_app/src/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// `DashboardController` is responsible for managing the state and navigation
/// within your dashboard, while the `PersistentView` widget is responsible for
/// displaying the content of the selected tab and keeping its state alive when
/// switching between tabs. The combination of these components allows you to
/// create a persistent and navigable tabbed interface.
class DashboardController extends ChangeNotifier {
  /// This is a list that keeps track of the history of indices for the screens
  /// displayed in the dashboard. It initially contains a single value, `0`,
  /// which corresponds to the first screen.
  List<int> _indexHistory = [0];

  /// This is a list of `PersistentView` widgets wrapped in `ChangeNotifierProvider`.
  /// Each `PersistentView` is associated with a `TabNavigator` that contains a
  /// `TabItem` with a placeholder child widget `Placeholder()`. These `_screens`
  /// represent the content to be displayed on each tab or screen of your dashboard.
  ///
  /// The `_screens` list consists of the following:
  ///   1. A placeholder screen initially representing the first tab.
  ///   2. Another placeholder screen initially representing the second tab.
  ///   3. Yet another placeholder screen initially representing the third tab.
  ///   4. The `ProfileView` screen representing the fourth tab, which displays
  ///      the user's profile information.
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (_) => sl<CourseCubit>(),
            child: const HomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const ProfileView())),
      child: const PersistentView(),
    ),
  ];
  List<Widget> get screens => _screens;

  // This variable keeps track of the currently selected screen index.
  int _currentIndex = 3;
  int get currentIndex => _currentIndex;

  /// This method is used to change the current screen `index`. It takes an `index`
  /// parameter and updates `_currentIndex` with the new index. It also adds the
  /// new index to `_indexHistory` to keep track of the navigation history.
  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  /// This method is used to navigate back to the previous screen. It removes
  /// the last index from `_indexHistory` and updates `_currentIndex` with the
  /// new last index.
  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  /// This method is used to reset the screen index and history back to the
  /// initial state, with only the first screen `(index 0)` in `_indexHistory`.
  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
