import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `PersistentView` widget is responsible for displaying the content of the
/// selected tab and keeping its state alive when switching between tabs.
class PersistentView extends StatefulWidget {
  const PersistentView({this.body, super.key});

  final Widget? body;

  @override
  State<PersistentView> createState() => _PersistentViewState();
}

class _PersistentViewState extends State<PersistentView>
    with AutomaticKeepAliveClientMixin {
  /// In the `build` method, it checks if a custom `body` widget is provided.
  /// If not, it uses `context.watch<TabNavigator>().currentPage.child` to
  /// access the child widget of the current `TabNavigator`. This effectively
  /// displays the content of the currently selected tab.
  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// This is an optional parameter that allows you to provide a custom `body`
    /// widget to the `PersistentView`. If not provided, it defaults to using
    /// the `child` of the current `TabNavigator`.
    return widget.body ?? context.watch<TabNavigator>().currentPage.child;
  }

  /// This method is overridden to return `true`. This tells Flutter to keep
  /// the state of this widget alive even when it's not currently visible on
  /// the screen.
  ///
  /// This is typically used to preserve the state of widgets within a `TabView`
  /// or similar scenarios where you want to maintain state across tab changes.
  @override
  bool get wantKeepAlive => true;
}
