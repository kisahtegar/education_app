// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// The `SectionHeader` widget displays a section title and an optional "See All" button.
class SectionHeader extends StatelessWidget {
  /// Creates a `SectionHeader` widget.
  ///
  /// - [sectionTitle]: The title of the section.
  /// - [seeAll]: A boolean indicating whether the "See All" button should be displayed.
  /// - [onSeeAll]: A callback function to be executed when the "See All" button is pressed.
  const SectionHeader({
    required this.sectionTitle,
    required this.seeAll,
    required this.onSeeAll,
    super.key,
  });

  /// The title of the section.
  final String sectionTitle;

  /// A boolean indicating whether the "See All" button should be displayed.
  final bool seeAll;

  /// A callback function to be executed when the "See All" button is pressed.
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColour,
              ),
            ),
          ),
      ],
    );
  }
}
