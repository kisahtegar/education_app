import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/repos/course_repo.dart';

/// The `AddCourse` use case class is responsible for adding a new course to
/// the application. It utilizes the provided `CourseRepo` instance to perform
/// the operation and returns a `ResultFuture` to indicate success or failure.
class AddCourse extends UsecaseWithParams<void, Course> {
  /// Creates an `AddCourse` instance with the given `CourseRepo` dependency.
  const AddCourse(this._repo);

  final CourseRepo _repo;

  /// Executes the use case by adding the provided `Course` to the repository.
  /// It returns a `ResultFuture` to indicate the success or failure of the
  /// operation.
  @override
  ResultFuture<void> call(Course params) async => _repo.addCourse(params);
}
