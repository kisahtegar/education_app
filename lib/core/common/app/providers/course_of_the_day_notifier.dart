import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter/foundation.dart';

/// The `CourseOfTheDayNotifier` class is responsible for managing and notifying
/// changes to the "Course of the Day" within the application. It extends
/// `ChangeNotifier` to allow for tracking and updating the currently selected
/// course.
class CourseOfTheDayNotifier extends ChangeNotifier {
  /// The currently selected "Course of the Day."
  Course? _courseOfTheDay;

  /// Getter to access the current "Course of the Day."
  Course? get courseOfTheDay => _courseOfTheDay;

  /// Sets the "Course of the Day" and notifies listeners of the change.
  ///
  /// If a course is already set as the "Course of the Day," it will not be
  /// replaced, ensuring that once selected, the course remains consistent.
  void setCourseOfTheDay(Course course) {
    _courseOfTheDay ??= course;
    notifyListeners();
  }
}
