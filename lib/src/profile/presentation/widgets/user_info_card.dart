// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// A custom widget to display user information in a styled card format.
///
/// The `UserInfoCard` widget is designed to showcase various user-related
/// information in a visually appealing card. It includes the user's information
/// icon, title, and corresponding value.
///
/// Parameters:
/// - `infoThemeColour`: The color used as the background theme for the card.
/// - `infoIcon`: The widget representing an icon or image for the user information.
/// - `infoTitle`: The title or label for the displayed information.
/// - `infoValue`: The actual value or data associated with the information.
///
/// This widget uses a predefined layout structure, including a circular background
/// shape for the information icon and text elements for the title and value. It is
/// suitable for displaying user-specific details like course counts, scores, followers,
/// and more.
class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    required this.infoThemeColour,
    required this.infoIcon,
    required this.infoTitle,
    required this.infoValue,
    super.key,
  });

  final Color infoThemeColour;
  final Widget infoIcon;
  final String infoTitle;
  final String infoValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 156,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE4E6EA)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: infoThemeColour,
                shape: BoxShape.circle,
              ),
              child: Center(child: infoIcon),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  infoTitle,
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  infoValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
