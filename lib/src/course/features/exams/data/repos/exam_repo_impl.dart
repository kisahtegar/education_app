// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/datasources/exam_remote_data_src.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/src/course/features/exams/domain/repos/exam_repo.dart';

/// A concrete implementation of the [ExamRepo] interface responsible for
/// interacting with remote data sources to perform exam-related operations.
class ExamRepoImpl implements ExamRepo {
  /// Constructs an [ExamRepoImpl] instance with the specified [ExamRemoteDataSrc].
  ///
  /// - [_remoteDataSource] is the remote data source used for fetching and
  ///   uploading exam-related data.
  const ExamRepoImpl(this._remoteDataSource);

  final ExamRemoteDataSrc _remoteDataSource;

  /// Retrieves a list of exams for the specified [courseId].
  ///
  /// Returns a [ResultFuture] containing either a list of [Exam] on success
  /// (Right) or a [Failure] on failure (Left).
  @override
  ResultFuture<List<Exam>> getExams(String courseId) async {
    try {
      final result = await _remoteDataSource.getExams(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Uploads an [Exam] to the remote data source.
  ///
  /// Returns a [ResultFuture] with no data on success (Right) or a [Failure]
  /// on failure (Left).
  @override
  ResultFuture<void> uploadExam(Exam exam) async {
    try {
      await _remoteDataSource.uploadExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Updates an existing [Exam] on the remote data source.
  ///
  /// Returns a [ResultFuture] with no data on success (Right) or a [Failure]
  /// on failure (Left).
  @override
  ResultFuture<void> updateExam(Exam exam) async {
    try {
      await _remoteDataSource.updateExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Submits a user's exam results to the remote data source.
  ///
  /// Returns a [ResultFuture] with no data on success (Right) or a [Failure]
  /// on failure (Left).
  @override
  ResultFuture<void> submitExam(UserExam exam) async {
    try {
      await _remoteDataSource.submitExam(exam);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a list of exam questions for the specified [exam].
  ///
  /// Returns a [ResultFuture] containing either a list of [ExamQuestion] on success
  /// (Right) or a [Failure] on failure (Left).
  @override
  ResultFuture<List<ExamQuestion>> getExamQuestions(Exam exam) async {
    try {
      final result = await _remoteDataSource.getExamQuestions(exam);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a list of user's submitted exams.
  ///
  /// Returns a [ResultFuture] containing either a list of [UserExam] on success
  /// (Right) or a [Failure] on failure (Left).
  @override
  ResultFuture<List<UserExam>> getUserExams() async {
    try {
      final result = await _remoteDataSource.getUserExams();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a list of user's submitted exams for the specified [courseId].
  ///
  /// Returns a [ResultFuture] containing either a list of [UserExam] on success
  /// (Right) or a [Failure] on failure (Left).
  @override
  ResultFuture<List<UserExam>> getUserCourseExams(String courseId) async {
    try {
      final result = await _remoteDataSource.getUserCourseExams(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
