// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

/// A reusable sign-up form widget that includes input fields for user registration.
class SignUpForm extends StatefulWidget {
  /// Creates a [SignUpForm] widget with required controllers and form key.
  const SignUpForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.fullNameController,
    required this.formKey,
    super.key,
  });

  /// The controller for the email input field.
  final TextEditingController emailController;

  /// The controller for the password input field.
  final TextEditingController passwordController;

  /// The controller for the confirm password input field.
  final TextEditingController confirmPasswordController;

  /// The controller for the user's full name input field.
  final TextEditingController fullNameController;

  /// A global key for the form associated with this sign-up form.
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          /// Full name input field
          IField(
            controller: widget.fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 25),

          /// Email input field
          IField(
            controller: widget.emailController,
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 25),

          /// Password input field with show/hide password functionality
          IField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              icon: Icon(
                obscurePassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 25),

          /// Confirm password input field with show/hide password functionality
          IField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: obscureConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              icon: Icon(
                obscurePassword ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
