// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// The `IField` widget simplifies the creation of customizable text input
/// fields. It offers various options for customization, making it a versatile
/// choice for integrating input fields into your app's user interface.
class IField extends StatelessWidget {
  /// Creates an `IField` widget with customizable options.
  ///
  /// - `controller` is required and represents the TextEditingController used
  ///   to manage the input field's text.
  /// - `filled` determines whether the input field should have a filled
  ///   background.
  /// - `obscureText` specifies whether the input should obscure the entered
  ///   text (e.g., for password fields).
  /// - `readOnly` defines whether the input field is read-only.
  /// - `validator` is an optional callback function to validate the input value.
  /// - `fillColour` allows you to set a custom fill color for the input field.
  /// - `suffixIcon` provides an optional icon to display as a suffix.
  /// - `hintText` is the placeholder text displayed when the input field is empty.
  /// - `keyboardType` sets the keyboard type for the input.
  /// - `hintStyle` allows customization of the hint text's style.
  /// - `overrideValidator` specifies whether to override the default required
  ///   field validation.
  const IField({
    required this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // overwriting the default padding helps with that puffy look
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: filled,
        fillColor: fillColour,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
