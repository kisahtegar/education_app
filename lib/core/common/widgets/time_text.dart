// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:education_app/core/extensions/date_time_extensions.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// A widget for displaying time with automatic updates to reflect elapsed time.
class TimeText extends StatefulWidget {
  /// Creates a [TimeText] widget.
  ///
  /// - The [time] parameter specifies the initial time to display.
  /// - The optional [prefixText] parameter can be used to add text before the time.
  /// - The optional [style] parameter allows customizing the text style.
  /// - The optional [maxLines] parameter sets the maximum number of lines for the text.
  /// - The optional [overflow] parameter specifies how text should overflow.
  const TimeText(
    this.time, {
    super.key,
    this.prefixText,
    this.style,
    this.maxLines,
    this.overflow,
  });

  /// The initial time to display.
  final DateTime time;

  /// Text to display before the time (optional).
  final String? prefixText;

  /// The style for displaying the time (optional).
  final TextStyle? style;

  /// The maximum number of lines for the text (optional).
  final int? maxLines;

  /// How text should overflow (optional).
  final TextOverflow? overflow;

  @override
  State<TimeText> createState() => _TimeTextState();
}

class _TimeTextState extends State<TimeText> {
  // A timer that periodically updates the displayed time.
  Timer? timer;

  // The string representing the time ago.
  late String timeAgo;

  @override
  void initState() {
    super.initState();

    // Initialize the 'timeAgo' variable with the initial time.
    timeAgo = widget.time.timeAgo;

    // Create a timer to update the displayed time every second.
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Check if the widget is still mounted to avoid updating a disposed widget.
      if (mounted) {
        // Compare the current 'timeAgo' with the updated time.
        if (timeAgo != widget.time.timeAgo) {
          // If the time has changed, trigger a UI update by calling 'setState'.
          setState(() {
            timeAgo = widget.time.timeAgo;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks.
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.prefixText != null ? '${widget.prefixText}' : ''} $timeAgo',
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      style: widget.style ??
          const TextStyle(
            fontSize: 12,
            color: Colours.neutralTextColour,
          ),
    );
  }
}
