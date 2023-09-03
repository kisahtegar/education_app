import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// This is a utility class with a private constructor `const CoreUtils._()`.
/// The `_` prefix conventionally indicates that the constructor is private,
/// which means the class cannot be instantiated from outside.
class CoreUtils {
  const CoreUtils._();

  /// Displaying SnackBar notifications in a application.
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colours.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }
}
