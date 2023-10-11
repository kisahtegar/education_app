import 'package:education_app/src/quick_access/presentation/widgets/tab_tile.dart';
import 'package:flutter/material.dart';

/// The `QuickAccessTabBar` widget displays a row of tabs for quick access to
/// different categories.
///
/// It provides quick navigation to different sections, such as 'Document,'
/// 'Exam,' and 'Passed.' Users can tap on these tabs to switch between
/// different content categories within the Quick Access tab.
///
/// Example:
///
/// ```dart
/// QuickAccessTabBar()
/// ```
class QuickAccessTabBar extends StatelessWidget {
  /// Creates a `QuickAccessTabBar` widget.
  const QuickAccessTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabTile(index: 0, title: 'Document'),
        TabTile(index: 1, title: 'Exam'),
        TabTile(index: 2, title: 'Passed'),
      ],
    );
  }
}
