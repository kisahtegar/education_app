import 'package:flutter/material.dart';

/// A custom button that reacts to loading and disabled states.
///
/// The [ReactiveButton] widget is designed to provide a button with various
/// states such as normal, loading, and disabled. It allows you to easily
/// toggle between these states to create responsive user interfaces.
///
/// Example Usage:
///
/// ```dart
/// ReactiveButton(
///   loading: false, // Set to true to display a loading indicator.
///   disabled: false, // Set to true to disable the button.
///   text: 'Click Me!',
///   onPressed: () {
///     // Handle button click here
///     print('Button clicked!');
///   },
/// )
/// ```
class ReactiveButton extends StatelessWidget {
  /// Creates a [ReactiveButton] widget.
  const ReactiveButton({
    required this.loading,
    required this.disabled,
    required this.text,
    super.key,
    this.onPressed,
  });

  /// A boolean indicating whether the button is in a loading state.
  final bool loading;

  /// A boolean indicating whether the button is disabled.
  final bool disabled;

  /// A callback function to be invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// The text to display on the button.
  final String text;

  /// A boolean indicating whether the button is in a normal state.
  ///
  /// The button is considered normal when it is not in a loading or disabled
  /// state. This property can be used for conditional styling or behavior.
  bool get normal => !loading && !disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: normal ? onPressed : null,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Text(text),
    );
  }
}
