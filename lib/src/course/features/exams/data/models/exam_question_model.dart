// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/models/question_choice_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice.dart';

/// A concrete implementation of the [ExamQuestion] entity representing a
/// question in an exam.
///
/// This model class provides methods for creating instances of
/// [ExamQuestionModel] from different sources, including data maps received
/// during uploads, and copying instances with optional attribute values changed.
class ExamQuestionModel extends ExamQuestion {
  /// Constructs an [ExamQuestionModel] instance with the specified attributes.
  ///
  /// - [id] is the unique identifier of the question.
  /// - [examId] is the unique identifier of the exam this question belongs to.
  /// - [courseId] is the unique identifier of the course associated with the
  ///   question.
  /// - [questionText] is the text of the question.
  /// - [choices] is a list of choices for this multiple-choice question.
  /// - [correctAnswer] (optional) is the identifier of the correct choice.
  const ExamQuestionModel({
    required super.id,
    required super.courseId,
    required super.examId,
    required super.questionText,
    required super.choices,
    super.correctAnswer,
  });

  /// Creates an empty [ExamQuestionModel] instance for testing purposes.
  const ExamQuestionModel.empty()
      : this(
          id: 'Test String',
          examId: 'Test String',
          courseId: 'Test String',
          questionText: 'Test String',
          choices: const [],
          correctAnswer: 'Test String',
        );

  /// Constructs an [ExamQuestionModel] instance from a map of data.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   question.
  ExamQuestionModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          examId: map['examId'] as String,
          courseId: map['courseId'] as String,
          questionText: map['questionText'] as String,
          correctAnswer: map['correctAnswer'] as String,
          choices: List<DataMap>.from(map['choices'] as List<dynamic>)
              .map(QuestionChoiceModel.fromMap)
              .toList(),
        );

  /// Constructs an [ExamQuestionModel] instance from data received during an
  /// upload.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   question.
  ExamQuestionModel.fromUploadMap(DataMap map)
      : this(
          id: map['id'] as String? ?? '',
          examId: map['examId'] as String? ?? '',
          courseId: map['courseId'] as String? ?? '',
          questionText: map['question'] as String,
          correctAnswer: map['correct_answer'] as String,
          choices: List<DataMap>.from(map['answers'] as List<dynamic>)
              .map(QuestionChoiceModel.fromUploadMap)
              .toList(),
        );

  /// Creates a copy of this [ExamQuestionModel] with optional attribute values
  /// changed.
  ///
  /// - [id] (optional) is the unique identifier of the question.
  /// - [examId] (optional) is the unique identifier of the exam this question
  ///   belongs to.
  /// - [courseId] (optional) is the unique identifier of the course associated
  ///   with the question.
  /// - [questionText] (optional) is the text of the question.
  /// - [choices] (optional) is a list of choices for this multiple-choice
  ///   question.
  /// - [correctAnswer] (optional) is the identifier of the correct choice.
  ExamQuestionModel copyWith({
    String? id,
    String? examId,
    String? courseId,
    String? questionText,
    List<QuestionChoice>? choices,
    String? correctAnswer,
  }) {
    return ExamQuestionModel(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      courseId: courseId ?? this.courseId,
      questionText: questionText ?? this.questionText,
      choices: choices ?? this.choices,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  /// Converts this [ExamQuestionModel] instance into a data map.
  ///
  /// The data map includes the [id], [examId], [courseId], [questionText],
  /// [choices], and [correctAnswer] attributes.
  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'examId': examId,
      'courseId': courseId,
      'questionText': questionText,
      'choices': choices
          .map((choice) => (choice as QuestionChoiceModel).toMap())
          .toList(),
      'correctAnswer': correctAnswer,
    };
  }
}
