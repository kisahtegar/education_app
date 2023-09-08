// ignore_for_file: comment_references, lines_longer_than_80_chars

import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A custom widget for displaying expandable text with a "Show more" / "Show
/// less" toggle.
///
/// The `ExpandableText` widget is designed to display long text content in a
/// constrained space, providing an option to expand or collapse the text. It
/// is often used for descriptions, articles, or comments that may be too long
/// to display fully.
///
/// The widget initially displays a truncated version of the text with a "Show
/// more" button. When the "Show more" button is tapped, the full text is
/// revealed. Tapping again collapses the text. Users can toggle between the
/// expanded and collapsed states.
///
/// Example:
/// ```dart
/// ExpandableText(
///   context,
///   text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
///   style: TextStyle(fontSize: 16),
/// )
/// ```
class ExpandableText extends StatefulWidget {
  /// Creates an [ExpandableText] widget.
  ///
  /// - The [context] parameter is required to access the current context's
  ///   dimensions.
  /// - The [text] parameter is the text content to be displayed in the widget.
  /// - The [style] parameter is an optional text style for customizing the
  ///   text's appearance.
  const ExpandableText(
    this.context, {
    required this.text,
    super.key,
    this.style,
  });

  /// The current build context, used to access context-specific properties.
  final BuildContext context;

  /// The text content to be displayed in the widget.
  final String text;

  /// An optional text style to customize the appearance of the text.
  final TextStyle? style;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;
  late TextSpan textSpan;
  late TextPainter textPainter;

  /// Initializes the state of the [_ExpandableTextState].
  ///
  /// This method is called automatically when the state object is created.
  /// In this implementation, it sets up the initial state and measurements for
  /// the text. Specifically, it calculates whether the text should be initially
  /// displayed as expanded or truncated based on the maximum line count and
  /// layout constraints.
  ///
  /// It constructs a [TextSpan] with the provided [text] and calculates the
  /// text layout with a maximum line count of 2 if not expanded, or `null` if
  /// expanded.
  ///
  /// This setup ensures that the text initially displays a truncated version
  /// with a "Show more" button when the text exceeds the maximum line count.
  @override
  void initState() {
    textSpan = TextSpan(text: widget.text);

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: expanded ? null : 2,
    )..layout(maxWidth: widget.context.width * .9);
    super.initState();
  }

  @override
  void dispose() {
    textPainter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultStyle = TextStyle(
      height: 1.8,
      fontSize: 16,
      color: Colours.neutralTextColour,
    );
    return Container(
      child: textPainter.didExceedMaxLines
          ? _buildExpandableText(
              defaultStyle,
            ) // Display expandable text if needed
          : Text(
              widget.text,
              style: widget.style ?? defaultStyle,
            ), // Display the full text
    );
  }

  /// Function to build expandable text with "Show more" / "Show less" button
  RichText _buildExpandableText(TextStyle defaultStyle) {
    return RichText(
      text: TextSpan(
        text: expanded
            ? widget.text // Show full text if expanded
            : '${widget.text.substring(0, _getTruncateIndex())}...', // Truncate text
        style: widget.style ?? defaultStyle,
        children: [
          TextSpan(
            text: expanded ? ' Show less' : 'Show more', // Toggle button text
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  expanded = !expanded; // Toggle expanded state
                });
              },
            style: const TextStyle(
              color: Colours.primaryColour,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Function to get the index at which text should be truncated
  int _getTruncateIndex() {
    return textPainter
        .getPositionForOffset(
          Offset(
            widget.context.width,
            widget.context.height,
          ),
        )
        .offset;
  }
}
