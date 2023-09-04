// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// The `RoundedButton` widget simplifies the creation of rounded buttons with
/// customizable colors. It offers an easy way to create visually appealing
/// buttons for your app's user interface.
class RoundedButton extends StatelessWidget {
  /// Creates a `RoundedButton` widget with customizable options.
  ///
  /// - `label` is required and represents the text displayed on the button.
  /// - `onPressed` is a required callback function triggered when the button is
  ///   pressed.
  /// - `buttonColour` allows you to set a custom background color for the button.
  ///   If not provided, it defaults to the primary app color.
  /// - `labelColour` sets the color of the button's label text. If not provided,
  ///   it defaults to white.
  const RoundedButton({
    required this.label,
    required this.onPressed,
    this.buttonColour,
    this.labelColour,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColour;
  final Color? labelColour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.primaryColour,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
