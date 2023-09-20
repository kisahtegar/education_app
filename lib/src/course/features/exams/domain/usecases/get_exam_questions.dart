// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `GetExamQuestions` use case retrieves a list of exam questions for a
/// given [Exam].
///
/// This use case takes an [Exam] as input and calls the `getExamQuestions` method
/// from the associated [ExamRepo] to fetch the list of [ExamQuestion] instances.
/// It returns a [ResultFuture] containing the list of questions on success or
/// an error on failure.
class GetExamQuestions
    extends FutureUsecaseWithParams<List<ExamQuestion>, Exam> {
  /// Constructs a `GetExamQuestions` use case with the provided [ExamRepo].
  const GetExamQuestions(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `getExamQuestions` method from the
  /// associated [ExamRepo] with the provided [Exam].
  ///
  /// Returns a [ResultFuture] containing a list of [ExamQuestion] instances on
  /// success or an error on failure.
  @override
  ResultFuture<List<ExamQuestion>> call(Exam params) =>
      _repo.getExamQuestions(params);
}
