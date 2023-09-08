// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// The `CoreUtils` class provides utility functions for common tasks within
/// your application. It has a private constructor `const CoreUtils._()` to
/// prevent external instantiation.
class CoreUtils {
  const CoreUtils._();

  /// Displays a SnackBar notification within the application.
  ///
  /// The [context] parameter is used to obtain the `ScaffoldMessenger` for
  /// showing the SnackBar, and the [message] parameter contains the message to
  /// be displayed.
  ///
  /// Usage:
  /// ```dart
  /// CoreUtils.showSnackBar(context, 'Your message goes here');
  /// ```
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

  /// Displays a loading dialog within the application.
  ///
  /// The [context] parameter is used to obtain the current [BuildContext] to
  /// show the loading dialog. This dialog typically includes a spinning
  /// CircularProgressIndicator to indicate ongoing background work.
  ///
  /// Usage:
  /// ```dart
  /// CoreUtils.showLoadingDialog(context);
  /// ```
  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Opens the image picker to allow the user to select an image from the gallery.
  ///
  /// This function uses the [ImagePicker] package to display the image picker
  /// dialog and returns the selected image as a [File] object.
  ///
  /// Example:
  /// ```dart
  /// final File? selectedImage = await CoreUtils.pickImage();
  /// if (selectedImage != null) {
  ///   // Display or process the selected image.
  /// }
  /// ```
  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
