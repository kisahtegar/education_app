// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// The `PopupItem` widget is useful for creating structured items within popups
/// or dropdown menus, often used in scenarios like app settings, filter options,
/// or selection menus. It combines a textual label with an icon to provide a
/// clear and visually appealing representation of each item.
///
/// This widget takes two required parameters:
///
/// - [title]: The textual label or title of the item.
/// - [icon]: The icon widget that represents the item visually.
///
/// Typically, you would use the `PopupItem` widget as children of a [PopupMenuButton]
/// or similar widgets to create a list of selectable options within your app.
///
/// Example:
///
/// ```dart
/// PopupMenuButton<void>(
///   itemBuilder: (context) {
///     return <PopupMenuEntry<void>>[
///       PopupMenuItem<void>(
///         value: 'option1',
///         child: PopupItem(
///           title: 'Option 1',
///           icon: Icon(Icons.check),
///         ),
///       ),
///       PopupMenuItem<void>(
///         value: 'option2',
///         child: PopupItem(
///           title: 'Option 2',
///           icon: Icon(Icons.check),
///         ),
///       ),
///     ];
///   },
///   // ...
/// )
/// ```
class PopupItem extends StatelessWidget {
  /// Creates a `PopupItem` widget with the provided [title] and [icon].
  const PopupItem({required this.title, required this.icon, super.key});

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        icon,
      ],
    );
  }
}
