// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `UpdateExam` use case allows updating an existing exam.
///
/// This use case takes an [Exam] as input and calls the `updateExam` method from
/// the associated [ExamRepo] to update the exam. It returns a [ResultFuture]
/// indicating the success or failure of the operation. Successful update ensures
/// that exam details, such as title, description, and time limit, are modified.
class UpdateExam extends FutureUsecaseWithParams<void, Exam> {
  /// Constructs an `UpdateExam` use case with the provided [ExamRepo].
  const UpdateExam(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `updateExam` method from the associated
  /// [ExamRepo].
  ///
  /// Takes an [Exam] as input, representing the updated exam information. Returns
  /// a [ResultFuture] indicating the success or failure of the exam update.
  @override
  ResultFuture<void> call(Exam params) => _repo.updateExam(params);
}
