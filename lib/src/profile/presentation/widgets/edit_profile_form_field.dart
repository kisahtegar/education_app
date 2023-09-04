// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';

/// The `EditProfileFormField` widget is used to create a form field for editing
/// user profile information. It consists of a title, an input field controlled
/// by a [TextEditingController], an optional hint text, and an optional read - only
/// mode.
///
/// This widget is typically used within a user profile editing screen to allow
/// users to modify specific fields like their full name, email, password, etc.
///
/// Parameters:
/// - `fieldTitle`: The title or label of the form field.
/// - `controller`: A [TextEditingController] to control the content of the form field.
/// - `hintText`: An optional hint text to display within the form field.
/// - `readOnly`: An optional boolean flag to determine if the field is in read-only mode.
///
/// Usage:
///
/// ```dart
/// EditProfileFormField(
///   fieldTitle: 'FULL NAME',
///   controller: fullNameController,
///   hintText: 'Enter your full name',
/// )
/// ```
class EditProfileFormField extends StatelessWidget {
  /// Creates an [EditProfileFormField] widget.
  const EditProfileFormField({
    required this.fieldTitle,
    required this.controller,
    super.key,
    this.hintText,
    this.readOnly = false,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        IField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
