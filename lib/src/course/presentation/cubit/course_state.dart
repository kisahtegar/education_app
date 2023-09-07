part of 'course_cubit.dart';

/// The `CourseState` represents different UI states for course-related
/// operations.
sealed class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the course-related UI.
final class CourseInitial extends CourseState {
  const CourseInitial();
}

/// Indicates that courses are currently being loaded.
final class LoadingCourses extends CourseState {
  const LoadingCourses();
}

/// Indicates that a new course is being added.
final class AddingCourse extends CourseState {
  const AddingCourse();
}

/// Indicates that a course has been successfully added.
final class CourseAdded extends CourseState {
  const CourseAdded();
}

/// Represents the state when a list of courses is successfully loaded.
final class CoursesLoaded extends CourseState {
  const CoursesLoaded(this.courses);

  final List<Course> courses;

  @override
  List<Object> get props => [courses];
}

/// Represents an error state with an associated error message.
final class CourseError extends CourseState {
  const CourseError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
