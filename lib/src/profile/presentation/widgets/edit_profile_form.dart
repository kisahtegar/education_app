// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/src/profile/presentation/widgets/edit_profile_form_field.dart';
import 'package:flutter/material.dart';

/// The `EditProfileForm` widget is used to display a form for editing a user's
/// profile information. It contains several `EditProfileFormField` widgets for
/// different user attributes such as full name, email, password, and bio.
///
/// This widget is typically used within a user profile editing screen to allow
/// users to update their personal information.
///
/// Parameters:
/// - `fullNameController`: A [TextEditingController] for the full name field.
/// - `emailController`: A [TextEditingController] for the email field.
/// - `passwordController`: A [TextEditingController] for the password field.
/// - `oldPasswordController`: A [TextEditingController] for the current password field.
/// - `bioController`: A [TextEditingController] for the bio field.
///
/// Usage:
///
/// ```dart
/// EditProfileForm(
///   fullNameController: _fullNameController,
///   emailController: _emailController,
///   passwordController: _passwordController,
///   oldPasswordController: _oldPasswordController,
///   bioController: _bioController,
/// )
/// ```
class EditProfileForm extends StatelessWidget {
  /// Creates an [EditProfileForm] widget.
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          fieldTitle: 'FULL NAME',
          controller: fullNameController,
          hintText: context.currentUser!.fullName,
        ),
        EditProfileFormField(
          fieldTitle: 'EMAIL',
          controller: emailController,
          hintText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileFormField(
          fieldTitle: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        StatefulBuilder(
          builder: (_, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              fieldTitle: 'NEW PASSWORD',
              controller: passwordController,
              hintText: '********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        EditProfileFormField(
          fieldTitle: 'BIO',
          controller: bioController,
          hintText: context.currentUser!.bio,
        ),
      ],
    );
  }
}
