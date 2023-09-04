import 'package:education_app/core/common/widgets/i_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

/// A reusable sign-in form widget that includes input fields for email and
/// password.
class SignInForm extends StatefulWidget {
  /// Creates a [SignInForm] widget with required controllers and form key.
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  /// The controller for the email input field.
  final TextEditingController emailController;

  /// The controller for the password input field.
  final TextEditingController passwordController;

  /// A global key for the form associated with this sign-in form.
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
