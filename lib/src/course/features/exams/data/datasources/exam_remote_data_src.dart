// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_model.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_question_model.dart';
import 'package:education_app/src/course/features/exams/data/models/question_choice_model.dart';
import 'package:education_app/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrintStack;

abstract class ExamRemoteDataSrc {
  Future<List<ExamModel>> getExams(String courseId);

  Future<void> uploadExam(Exam exam);

  Future<List<ExamQuestionModel>> getExamQuestions(Exam exam);

  Future<void> updateExam(Exam exam);

  Future<void> submitExam(UserExam exam);

  Future<List<UserExamModel>> getUserExams();

  Future<List<UserExamModel>> getUserCourseExams(String courseId);
}

/// The implementation of the [ExamRemoteDataSrc] interface responsible for
/// interacting with remote data sources for exams and related operations.
class ExamRemoteDataSrcImpl implements ExamRemoteDataSrc {
  const ExamRemoteDataSrcImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Retrieves a list of exam questions associated with a given Exam object
  /// from Firestore. It authorizes the user, queries the Firestore database,
  /// and converts the retrieved data into a list of ExamQuestionModel instances.
  @override
  Future<List<ExamQuestionModel>> getExamQuestions(Exam exam) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve exam questions from Firestore based on exam and course IDs.
      final result = await _firestore
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .doc(exam.id)
          .collection('questions')
          .get();

      // Map Firestore documents to [ExamQuestionModel] instances.
      return result.docs
          .map((doc) => ExamQuestionModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Fetches a list of exams related to a specified course ID from Firestore.
  /// It authorizes the user, queries Firestore, and converts the data into a
  /// list of ExamModel instances.
  @override
  Future<List<ExamModel>> getExams(String courseId) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve exams associated with the specified course from Firestore.
      final result = await _firestore
          .collection('courses')
          .doc(courseId)
          .collection('exams')
          .get();

      // Map Firestore documents to [ExamModel] instances.
      return result.docs.map((doc) => ExamModel.fromMap(doc.data())).toList();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Retrieves a list of user-specific exams for a particular course from
  /// Firestore. It authorizes the user, queries Firestore, and converts the
  /// data into a list of UserExamModel instances.
  @override
  Future<List<UserExamModel>> getUserCourseExams(String courseId) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve user-specific course exams from Firestore.
      final result = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('courses')
          .doc(courseId)
          .collection('exams')
          .get();

      // Map Firestore documents to [UserExamModel] instances.
      return result.docs
          .map((doc) => UserExamModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Retrieves a list of user-specific exams from Firestore. It first authorizes
  /// the user, retrieves a list of enrolled courses, and then fetches the exams
  /// for each course. It returns a combined list of UserExamModel instances.
  @override
  Future<List<UserExamModel>> getUserExams() async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Retrieve user-specific exams and courses from Firestore.
      final result = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('courses')
          .get();

      // Extract the list of course IDs.
      final courses = result.docs.map((e) => e.id).toList();

      // Initialize an empty list to store user exams.
      final exams = <UserExamModel>[];

      // Retrieve exams for each course.
      for (final course in courses) {
        final courseExams = await getUserCourseExams(course);
        exams.addAll(courseExams);
      }

      return exams;
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Submits a user's exam results to Firestore. It authorizes the user, stores
  /// the exam details, calculates the score, updates the user's points, and
  /// enrolls the user in the course if necessary.
  @override
  Future<void> submitExam(UserExam exam) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      final user = _auth.currentUser!;

      // Add the user to the course for exam history tracking.
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('courses')
          .doc(exam.courseId)
          .set({
        'courseId': exam.courseId,
        'courseName': exam.examTitle,
      });

      // Store the user's exam details.
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .doc(exam.examId)
          .set((exam as UserExamModel).toMap());

      // Calculate the user's exam score and update it.
      final totalPoints = exam.answers
          .where((answer) => answer.isCorrect)
          .fold<int>(0, (previousValue, _) => previousValue + 1);

      final pointPercent = totalPoints / exam.totalQuestions;
      final points = pointPercent * 100;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'points': FieldValue.increment(points)});

      // Check if the user is already enrolled in the course and enroll if not.
      final userData = await _firestore.collection('users').doc(user.uid).get();

      final alreadyEnrolled = (userData.data()?['enrolledCourseIds'] as List?)
              ?.contains(exam.courseId) ??
          false;

      if (!alreadyEnrolled) {
        await _firestore.collection('users').doc(user.uid).update({
          'enrolledCourseIds': FieldValue.arrayUnion([exam.courseId]),
        });
      }
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Updates exam details in Firestore, including the exam itself and its
  /// associated questions. It authorizes the user, updates the exam details,
  /// and batch updates the questions if they exist.
  @override
  Future<void> updateExam(Exam exam) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Update the exam details in Firestore.
      await _firestore
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .doc(exam.id)
          .update((exam as ExamModel).toMap());

      // Update exam questions if available.
      final questions = exam.questions;

      if (questions != null && questions.isNotEmpty) {
        final batch = _firestore.batch();
        for (final question in questions) {
          final questionDocRef = _firestore
              .collection('courses')
              .doc(exam.courseId)
              .collection('exams')
              .doc(exam.id)
              .collection('questions')
              .doc(question.id);
          batch.update(questionDocRef, (question as ExamQuestionModel).toMap());
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  /// Uploads a new exam to Firestore, including its questions and choices. It
  /// authorizes the user, creates a new Firestore document for the exam, and
  /// batch uploads the questions and choices. It also increments the number of
  /// sexams for the associated course.
  @override
  Future<void> uploadExam(Exam exam) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_auth);

      // Create a new Firestore document for the uploaded exam.
      final examDocRef = _firestore
          .collection('courses')
          .doc(exam.courseId)
          .collection('exams')
          .doc();
      final examToUpload = (exam as ExamModel).copyWith(id: examDocRef.id);
      await examDocRef.set(examToUpload.toMap());

      // Upload exam questions if available.
      final questions = exam.questions;
      if (questions != null && questions.isNotEmpty) {
        final batch = _firestore.batch();
        for (final question in questions) {
          final questionDocRef = examDocRef.collection('questions').doc();
          var questionToUpload = (question as ExamQuestionModel).copyWith(
            id: questionDocRef.id,
            examId: examDocRef.id,
            courseId: exam.courseId,
          );

          final newChoices = <QuestionChoiceModel>[];
          for (final choice in questionToUpload.choices) {
            final newChoice = (choice as QuestionChoiceModel).copyWith(
              questionId: questionDocRef.id,
            );
            newChoices.add(newChoice);
          }
          questionToUpload = questionToUpload.copyWith(choices: newChoices);
          batch.set(questionDocRef, questionToUpload.toMap());
        }
        await batch.commit();
      }

      // Increment the number of exams for the associated course.
      await _firestore.collection('courses').doc(exam.courseId).update({
        'numberOfExams': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
