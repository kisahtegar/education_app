import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `GetExams` use case retrieves a list of exams for a given course ID.
///
/// This use case takes a [String] representing the course ID as input and
/// calls the `getExams` method from the associated [ExamRepo] to fetch the list
/// of [Exam] instances for the specified course. It returns a [ResultFuture]
/// containing the list of exams on success or an error on failure.
class GetExams extends FutureUsecaseWithParams<List<Exam>, String> {
  /// Constructs a `GetExams` use case with the provided [ExamRepo].
  const GetExams(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `getExams` method from the associated
  /// [ExamRepo] with the provided course ID.
  ///
  /// Returns a [ResultFuture] containing a list of [Exam] instances on success
  /// or an error on failure.
  @override
  ResultFuture<List<Exam>> call(String params) => _repo.getExams(params);
}
