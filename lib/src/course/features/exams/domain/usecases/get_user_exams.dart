import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `GetUserExams` use case retrieves a list of user-specific exams.
///
/// This use case takes no input parameters and calls the `getUserExams` method
/// from the associated [ExamRepo] to fetch a list of [UserExam] instances that
/// are specific to the user. It returns a [ResultFuture] containing the list of
/// user-specific exams on success or an error on failure.
class GetUserExams extends FutureUsecaseWithoutParams<List<UserExam>> {
  /// Constructs a `GetUserExams` use case with the provided [ExamRepo].
  const GetUserExams(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `getUserExams` method from the
  /// associated [ExamRepo].
  ///
  /// Returns a [ResultFuture] containing a list of [UserExam] instances
  /// specific to the user on success or an error on failure.
  @override
  ResultFuture<List<UserExam>> call() => _repo.getUserExams();
}
