import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter/material.dart';

/// A custom tile widget for displaying a course.
///
/// The `CourseTile` widget is used to display a single course in a compact
/// tile format. It includes the course image, title, and supports tap
/// interaction. This widget is typically used in grid or list views to
/// represent multiple courses.
///
/// Example:
/// ```dart
/// CourseTile(
///   course: myCourse,
///   onTap: () {
///     // Handle tile tap event.
///   },
/// )
/// ```
class CourseTile extends StatelessWidget {
  /// Creates a [CourseTile] with the specified [course] and an optional [onTap]
  /// callback for handling interactions.
  const CourseTile({required this.course, this.onTap, super.key});

  /// The course entity to be displayed in the tile.
  final Course course;

  /// A callback function invoked when the tile is tapped. (Optional)
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 54,
        child: Column(
          children: [
            SizedBox(
              height: 54,
              width: 54,
              child: Image.network(
                course.image!,
                height: 32,
                width: 32,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              course.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
