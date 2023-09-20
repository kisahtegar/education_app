// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// The `UploadExam` use case allows uploading a new exam.
///
/// This use case takes an [Exam] as input and calls the `uploadExam` method from
/// the associated [ExamRepo] to upload the exam. It returns a [ResultFuture]
/// indicating the success or failure of the operation. A successful upload
/// results in the creation of a new exam with the provided details.
class UploadExam extends FutureUsecaseWithParams<void, Exam> {
  /// Constructs an `UploadExam` use case with the provided [ExamRepo].
  const UploadExam(this._repo);

  final ExamRepo _repo;

  /// Executes the use case by calling the `uploadExam` method from the associated
  /// [ExamRepo].
  ///
  /// Takes an [Exam] as input, representing the exam to be uploaded. Returns a
  /// [ResultFuture] indicating the success or failure of the exam upload.
  @override
  ResultFuture<void> call(Exam params) => _repo.uploadExam(params);
}
