// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/res/colours.dart';
import 'package:flutter/material.dart';

/// A custom tile widget for displaying course information.
///
/// The `CourseInfoTile` widget is used to display information about a course
/// in a row format, typically in a list or grid. It includes an image, title,
/// and subtitle. The widget allows for an optional [onTap] callback for
/// handling interactions.
///
/// Example:
/// ```dart
/// CourseInfoTile(
///   image: 'assets/course_image.png',
///   title: 'Course Title',
///   subtitle: 'Instructor: John Doe',
///   onTap: () {
///     // Handle tile tap event.
///   },
/// )
/// ```
class CourseInfoTile extends StatelessWidget {
  /// Creates a [CourseInfoTile] with the specified [image], [title], [subtitle],
  /// and an optional [onTap] callback.
  const CourseInfoTile({
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTap,
    super.key,
  });

  /// The image asset path or URL representing the course.
  final String image;

  /// The title of the course.
  final String title;

  /// The subtitle or additional information about the course.
  final String subtitle;

  /// A callback function invoked when the tile is tapped. (Optional)
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Transform.scale(scale: 1.48, child: Image.asset(image)),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colours.neutralTextColour,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
