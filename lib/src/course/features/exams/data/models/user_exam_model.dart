// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/models/user_choice_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';

/// A concrete implementation of the [UserExam] entity representing a user's
/// submitted exam.
class UserExamModel extends UserExam {
  /// Constructs a [UserExamModel] instance with the specified attributes.
  ///
  /// - [examId] is the unique identifier of the exam.
  /// - [courseId] is the unique identifier of the course associated with the exam.
  /// - [answers] is a list of user's choices for each question in the exam.
  /// - [examTitle] is the title of the exam.
  /// - [totalQuestions] is the total number of questions in the exam.
  /// - [dateSubmitted] is the date and time when the exam was submitted.
  /// - [examImageUrl] is the URL of the exam's image (if available).
  const UserExamModel({
    required super.examId,
    required super.courseId,
    required super.answers,
    required super.examTitle,
    required super.totalQuestions,
    required super.dateSubmitted,
    super.examImageUrl,
  });

  /// Creates an empty [UserExamModel] instance for testing purposes.
  ///
  /// - [date] (optional) is the date and time when the exam was submitted.
  UserExamModel.empty([DateTime? date])
      : this(
          examId: 'Test String',
          courseId: 'Test String',
          totalQuestions: 0,
          examTitle: 'Test String',
          examImageUrl: 'Test String',
          dateSubmitted: date ?? DateTime.now(),
          answers: const [],
        );

  /// Constructs a [UserExamModel] instance from a map of data.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   user's exam.
  UserExamModel.fromMap(DataMap map)
      : this(
          examId: map['examId'] as String,
          courseId: map['courseId'] as String,
          totalQuestions: (map['totalQuestions'] as num).toInt(),
          examTitle: map['examTitle'] as String,
          examImageUrl: map['examImageUrl'] as String?,
          dateSubmitted: (map['dateSubmitted'] as Timestamp).toDate(),
          answers: List<DataMap>.from(map['answers'] as List<dynamic>)
              .map(UserChoiceModel.fromMap)
              .toList(),
        );

  /// Creates a copy of this [UserExamModel] with optional attribute values changed.
  ///
  /// - [examId] (optional) is the unique identifier of the exam.
  /// - [courseId] (optional) is the unique identifier of the course associated
  ///   with the exam.
  /// - [totalQuestions] (optional) is the total number of questions in the exam.
  /// - [examTitle] (optional) is the title of the exam.
  /// - [examImageUrl] (optional) is the URL of the exam's image (if available).
  /// - [dateSubmitted] (optional) is the date and time when the exam was submitted.
  /// - [answers] (optional) is a list of user's choices for each question in the exam.
  UserExamModel copyWith({
    String? examId,
    String? courseId,
    int? totalQuestions,
    String? examTitle,
    String? examImageUrl,
    DateTime? dateSubmitted,
    List<UserChoice>? answers,
  }) {
    return UserExamModel(
      examId: examId ?? this.examId,
      courseId: courseId ?? this.courseId,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      examTitle: examTitle ?? this.examTitle,
      examImageUrl: examImageUrl ?? this.examImageUrl,
      dateSubmitted: dateSubmitted ?? this.dateSubmitted,
      answers: answers ?? this.answers,
    );
  }

  /// Converts this [UserExamModel] instance into a data map.
  ///
  /// The data map includes the [examId], [courseId], [totalQuestions],
  /// [examTitle], [examImageUrl], [dateSubmitted], and [answers] attributes.
  DataMap toMap() {
    return <String, dynamic>{
      'examId': examId,
      'courseId': courseId,
      'totalQuestions': totalQuestions,
      'examTitle': examTitle,
      'examImageUrl': examImageUrl,
      'dateSubmitted': FieldValue.serverTimestamp(),
      'answers':
          answers.map((answer) => (answer as UserChoiceModel).toMap()).toList(),
    };
  }
}
