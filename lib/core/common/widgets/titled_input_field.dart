// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// The `TitledInputField` widget combines a title, input field, and optional
/// suffix icon into a single form field for user input. It is commonly used for
/// collecting text-based input from users.
class TitledInputField extends StatelessWidget {
  /// Creates a `TitledInputField` widget with the specified parameters.
  ///
  /// - [controller]: The controller for managing the input field's text.
  /// - [title]: The title or label displayed above the input field.
  /// - [required]: Indicates whether the input field is required (default is true).
  /// - [hintText]: An optional hint text displayed inside the input field when it's empty.
  /// - [hintStyle]: An optional style for the hint text.
  /// - [suffixIcon]: An optional icon displayed on the right side of the input field.
  const TitledInputField({
    required this.controller,
    required this.title,
    this.required = true,
    super.key,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
  });

  /// Indicates whether the input field is required (default is true).
  final bool required;

  /// The controller for managing the input field's text.
  final TextEditingController controller;

  /// The title or label displayed above the input field.
  final String title;

  /// An optional hint text displayed inside the input field when it's empty.
  final String? hintText;

  /// An optional style for the hint text.
  final TextStyle? hintStyle;

  /// An optional icon displayed on the right side of the input field.
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.neutralTextColour,
                ),
                children: !required
                    ? null
                    : [
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colours.redColour),
                        ),
                      ],
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 10),
        IField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          overrideValidator: true,
          validator: (value) {
            if (!required) return null;
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
