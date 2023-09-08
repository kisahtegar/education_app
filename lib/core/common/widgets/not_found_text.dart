import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The `NotFoundText` widget displays a centered text message with a specific
/// style, typically used for indicating that no content was found or available.
class NotFoundText extends StatelessWidget {
  /// Creates a `NotFoundText` widget with the provided [text].
  const NotFoundText(this.text, {super.key});

  /// The text message to display.
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
