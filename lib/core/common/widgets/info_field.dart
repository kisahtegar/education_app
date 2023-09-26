import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// A custom text input field with optional features.
///
/// The [InfoField] widget is a versatile text input field that allows you to
/// customize its appearance and behavior. You can specify properties such as
/// the controller, hint text, keyboard type, and more.
class InfoField extends StatelessWidget {
  /// Creates an [InfoField] widget.
  ///
  /// - [controller]: The controller for managing the text input.
  /// - [onEditingComplete]: A callback function to be invoked when editing is
  ///   complete.
  /// - [hintText]: The hint text displayed when the field is empty.
  /// - [keyboardType]: The keyboard type for the text input.
  /// - [autoFocus]: Set to `true` to automatically focus the input field.
  /// - [labelText]: The label text displayed above the input field.
  /// - [focusNode]: A focus node that can be used to control the focus state.
  /// - [onTapOutside]: A callback function triggered when tapping outside the
  ///   field.
  /// - [onChanged]: A callback function triggered when the input value changes.
  /// - [border]: Set to `true` to enable the default border styling.
  /// - [suffixIcon]: An optional icon to display at the end of the input field.
  const InfoField({
    required this.controller,
    super.key,
    this.onEditingComplete,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.labelText,
    this.focusNode,
    this.onTapOutside,
    this.onChanged,
    this.border = false,
    this.suffixIcon,
  });

  /// The controller for managing the text input.
  final TextEditingController controller;

  /// A callback function to be invoked when editing is complete.
  final VoidCallback? onEditingComplete;

  /// The hint text displayed when the field is empty.
  final String? hintText;

  /// The keyboard type for the text input.
  final TextInputType keyboardType;

  /// Set to `true` to automatically focus the input field.
  final bool autoFocus;

  /// The label text displayed above the input field.
  final String? labelText;

  /// A focus node that can be used to control the focus state.
  final FocusNode? focusNode;

  /// A callback function triggered when tapping outside the field.
  final ValueChanged<PointerDownEvent>? onTapOutside;

  /// A callback function triggered when the input value changes.
  final ValueChanged<String?>? onChanged;

  /// Set to `true` to enable the default border styling.
  final bool border;

  /// An optional icon to display at the end of the input field.
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    const defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colours.primaryColour),
    );
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return TextField(
          controller: controller,
          autofocus: autoFocus,
          focusNode: focusNode,
          keyboardType: keyboardType,
          onEditingComplete: onEditingComplete,
          onTapOutside: onTapOutside ??
              (_) => FocusManager.instance.primaryFocus?.unfocus(),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: border ? defaultBorder : null,
            enabledBorder: border ? defaultBorder : null,
            contentPadding:
                border ? const EdgeInsets.symmetric(horizontal: 10) : null,
            suffixIcon: suffixIcon ??
                (controller.text.trim().isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: controller.clear,
                      )),
          ),
        );
      },
    );
  }
}
