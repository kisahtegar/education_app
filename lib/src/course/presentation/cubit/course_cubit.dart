import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/usecases/add_course.dart';
import 'package:education_app/src/course/domain/usecases/get_courses.dart';
import 'package:equatable/equatable.dart';

part 'course_state.dart';

/// The `CourseCubit` is responsible for managing the state related to course
/// operations.
class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required AddCourse addCourse,
    required GetCourses getCourses,
  })  : _addCourse = addCourse,
        _getCourses = getCourses,
        super(const CourseInitial());

  final AddCourse _addCourse;
  final GetCourses _getCourses;

  /// Adds a new course to the application.
  ///
  /// Emits [AddingCourse] state while the operation is in progress,
  /// and [CourseAdded] when the course is successfully added.
  /// In case of an error, [CourseError] state is emitted with an error message.
  Future<void> addCourse(Course course) async {
    emit(const AddingCourse());
    final result = await _addCourse(course);
    result.fold(
      (failure) => emit(CourseError(failure.errorMessage)),
      (_) => emit(const CourseAdded()),
    );
  }

  /// Retrieves a list of courses from the data source.
  ///
  /// Emits [LoadingCourses] state while loading is in progress,
  /// and [CoursesLoaded] with the list of courses when the operation succeeds.
  /// In case of an error, [CourseError] state is emitted with an error message.
  Future<void> getCourses() async {
    emit(const LoadingCourses());
    final result = await _getCourses();
    result.fold(
      (failure) => emit(CourseError(failure.errorMessage)),
      (courses) => emit(CoursesLoaded(courses)),
    );
  }
}
