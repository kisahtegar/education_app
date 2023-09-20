// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `SubmitExam` use case allows the user to submit an exam.
///
/// This use case takes a [UserExam] as input and calls the `submitExam` method
/// from the associated [ExamRepo] to submit the exam. It returns a [ResultFuture]
/// indicating the success or failure of the operation. Successful submission
/// allows the user's answers to be recorded for evaluation.
class SubmitExam extends FutureUsecaseWithParams<void, UserExam> {
  /// Constructs a `SubmitExam` use case with the provided [ExamRepo].
  const SubmitExam(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `submitExam` method from the
  /// associated [ExamRepo].
  ///
  /// Takes a [UserExam] as input, which represents the user's exam submission.
  /// Returns a [ResultFuture] indicating the success or failure of the exam
  /// submission.
  @override
  ResultFuture<void> call(UserExam params) => _repo.submitExam(params);
}
