// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `GetUserCourseExams` use case retrieves a list of user-specific exams
/// for a given course ID.
///
/// This use case takes a [String] representing the course ID as input and calls
/// the `getUserCourseExams` method from the associated [ExamRepo] to fetch the
/// list of [UserExam] instances specific to the user and the specified course.
/// It returns a [ResultFuture] containing the list of user-specific exams on
/// success or an error on failure.
class GetUserCourseExams
    extends FutureUsecaseWithParams<List<UserExam>, String> {
  /// Constructs a `GetUserCourseExams` use case with the provided [ExamRepo].
  const GetUserCourseExams(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `getUserCourseExams` method from the
  /// associated [ExamRepo] with the provided course ID.
  ///
  /// Returns a [ResultFuture] containing a list of [UserExam] instances specific
  /// to the user and the specified course on success or an error on failure.
  @override
  ResultFuture<List<UserExam>> call(String params) =>
      _repo.getUserCourseExams(params);
}
