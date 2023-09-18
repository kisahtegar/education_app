// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';

/// The `ExamRepo` abstract class defines the contract for repositories that
/// handle exam-related operations.
///
/// Implementations of this class provide methods to retrieve exams, exam questions,
/// upload exams, update exams, submit user exams, and retrieve user's exam history.
abstract class ExamRepo {
  /// Retrieves a list of exams associated with a specified course.
  ///
  /// Returns a [ResultFuture] containing a list of [Exam] instances on success.
  ResultFuture<List<Exam>> getExams(String courseId);

  /// Retrieves a list of exam questions for a given exam.
  ///
  /// Takes an [exam] as input and returns a [ResultFuture] containing a list of
  /// [ExamQuestion] instances on success.
  ResultFuture<List<ExamQuestion>> getExamQuestions(Exam exam);

  /// Uploads an exam to the repository.
  ///
  /// Takes an [exam] as input and returns a [ResultFuture] indicating the success
  /// or failure of the operation.
  ResultFuture<void> uploadExam(Exam exam);

  /// Updates an existing exam in the repository.
  ///
  /// Takes an [exam] as input and returns a [ResultFuture] indicating the success
  /// or failure of the operation.
  ResultFuture<void> updateExam(Exam exam);

  /// Submits a user's attempt at an exam.
  ///
  /// Takes a [UserExam] as input and returns a [ResultFuture] indicating the success
  /// or failure of the operation.
  ResultFuture<void> submitExam(UserExam exam);

  /// Retrieves a list of user exams.
  ///
  /// Returns a [ResultFuture] containing a list of [UserExam] instances on success.
  ResultFuture<List<UserExam>> getUserExams();

  /// Retrieves a list of user exams associated with a specified course.
  ///
  /// Takes a [courseId] as input and returns a [ResultFuture] containing a list
  /// of [UserExam] instances on success.
  ResultFuture<List<UserExam>> getUserCourseExams(String courseId);
}
