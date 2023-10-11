import 'package:education_app/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `TabTile` widget is a reusable UI component for creating individual tabs
/// within a tab bar. It is designed for use with a `QuickAccessTabController`
/// to manage and control the state of the tab.
///
/// The `TabTile` displays a text title and allows the user to select it by
/// tapping. When the tab is selected, it is highlighted with a background
/// color, while unselected tabs remain in a default state.
///
/// This widget uses the [Consumer] widget from the 'provider' package to
/// listen for changes in the `QuickAccessTabController`. It rebuilds itself
/// whenever the selected tab index changes to reflect the current state.
///
/// Example:
///
/// ```dart
/// TabTile(
///   index: 0,
///   title: 'Tab 1',
/// )
/// ```
class TabTile extends StatelessWidget {
  /// Creates a `TabTile` widget.
  const TabTile({required this.index, required this.title, super.key});

  /// The unique index of the tab.
  final int index;

  /// The text label to display on the tab.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickAccessTabController>(
      builder: (_, controller, __) {
        final isSelected = controller.currentIndex == index;
        return GestureDetector(
          onTap: () => controller.changeIndex(index),
          child: isSelected
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
        );
      },
    );
  }
}
