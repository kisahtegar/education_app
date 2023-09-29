import 'package:flutter/material.dart';

/// The `PickedResourceHorizontalText` widget is used to display a label and a
/// corresponding value in a horizontal layout. It is typically used to show
/// information about a picked resource with a label on the left and its value
/// on the right.
class PickedResourceHorizontalText extends StatelessWidget {
  /// Creates a `PickedResourceHorizontalText` widget with the specified [label]
  /// and [value].
  ///
  /// The [label] parameter represents the text label to display on the left
  /// side, and the [value] parameter represents the corresponding value to
  /// display on the right side.
  const PickedResourceHorizontalText({
    required this.label,
    required this.value,
    super.key,
  });

  /// The text label to be displayed on the left side.
  final String label;

  /// The corresponding value to be displayed on the right side.
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
