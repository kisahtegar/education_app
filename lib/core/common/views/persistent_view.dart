// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `PersistentView` widget is responsible for displaying the content of the
/// selected tab and maintaining its state when switching between tabs.
class PersistentView extends StatefulWidget {
  /// Creates a `PersistentView` widget with an optional custom `body`.
  ///
  /// The `body` parameter allows you to provide a custom widget to be displayed
  /// within this `PersistentView`. If not provided, it defaults to the child
  /// widget of the current `TabNavigator`, which corresponds to the content of
  /// the currently selected tab.
  const PersistentView({this.body, super.key});

  /// The custom widget to be displayed within this `PersistentView`. If not
  /// provided, it defaults to the child widget of the current `TabNavigator`.
  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  /// In the `build` method, this widget checks if a custom `body` widget is
  /// provided. If not, it uses `context.watch<TabNavigator>().currentPage.child`
  /// to access the child widget of the current `TabNavigator`. This effectively
  /// displays the content of the currently selected tab.
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  /// Overrides the `wantKeepAlive` property to return `true`. This informs Flutter
  /// to keep the state of this widget alive even when it's not currently visible
  /// on the screen. This is commonly used to preserve the state of widgets within
  /// a `TabView` or similar scenarios where you want to maintain state across tab
  /// changes.
  @override
  bool get wantKeepAlive => true;
}
