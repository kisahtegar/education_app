import 'package:education_app/core/common/widgets/time_text.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a time in a styled tile format.
class TimeTile extends StatelessWidget {
  /// Creates a [TimeTile] widget.
  ///
  /// The [time] parameter represents the date and time to display.
  /// The optional [prefixText] parameter can be used to display additional text
  /// before the time.
  const TimeTile(this.time, {super.key, this.prefixText});

  /// The date and time to display.
  final DateTime time;

  /// Additional text to display before the time.
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colours.primaryColour,
        borderRadius: BorderRadius.circular(90),
      ),
      child: TimeText(
        time,
        prefixText: prefixText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
