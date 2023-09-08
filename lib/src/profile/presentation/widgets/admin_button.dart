import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// A custom button widget designed for administrative actions.
///
/// The `AdminButton` widget displays a button with an icon and a label.
/// It is typically used for administrative actions or features that require
/// special privileges. The button's appearance is customized with a primary
/// background color and white text.
///
/// Example:
/// ```dart
/// AdminButton(
///   label: 'Delete User',
///   icon: Icons.delete,
///   onPressed: () {
///     // Perform administrative action.
///   },
/// )
/// ```
class AdminButton extends StatelessWidget {
  /// Creates an [AdminButton] with the specified [label], [icon], and
  /// [onPressed] callback.
  const AdminButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  /// The text label displayed on the button.
  final String label;

  /// The icon displayed next to the label on the button.
  final IconData icon;

  /// The callback function invoked when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      label: Text(label),
      icon: Icon(icon),
    );
  }
}
