// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The `NestedBackButton` widget provides a unified approach to handle
/// back navigation within nested routes or screens. It is designed to ensure
/// a consistent and reliable back navigation experience across different
/// platforms.
///
/// This widget first attempts to use a custom context extension method called
/// `pop()` to navigate back. If the `pop()` method is available and succeeds
/// in popping a route, it prevents the default behavior (typically popping
/// the current route) by returning `false`. In cases where the custom `pop()`
/// method is unavailable or fails to pop a route, it gracefully falls back
/// to using the standard Flutter Navigator to pop the current route.
class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    /// The `WillPopScope` widget intercepts and handles the back button press
    /// on Android devices. It wraps the widget tree's content and provides a
    /// callback function through its `onWillPop` parameter. This callback is
    /// executed when the back button is pressed.
    ///
    /// If the callback returns `true`, it allows the default system behavior
    /// (usually popping the current route) to take place. If it returns `false`,
    /// it prevents the default behavior.
    return WillPopScope(
      onWillPop: () async {
        try {
          // Attempt to use the custom context extension method `pop()` to
          // navigate back. This method is used to handle the navigation action
          // when it's possible to pop one level up in the navigation stack.
          // If popping succeeds (i.e., there is a route to pop), it returns
          // `false`, preventing the default behavior.
          context.pop();
          return false;
        } catch (_) {
          // If using the custom `pop()` method fails (e.g., because there are
          // no more routes to pop), this fallback code uses the standard
          // Flutter Navigator (`Navigator.of(context).pop()`) to pop the
          // current route. This is the default behavior.
          return true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            // Attempt to use the custom context extension method `pop()` to
            // navigate back.
            context.pop();
          } catch (_) {
            // If the context.pop() call fails (e.g., because there are no more
            // routes to pop), this line of code uses the standard Flutter
            // Navigator to pop the current route, which is the default behavior.
            Navigator.of(context).pop();
          }
        },
        // Use platform-specific icons for back navigation based on the
        // platform (iOS or Android).
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
