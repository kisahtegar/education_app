// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/src/course/features/exams/domain/entities/question_choice.dart';
import 'package:equatable/equatable.dart';

/// The `ExamQuestion` class represents a question within an educational exam.
///
/// An exam question typically includes details such as its unique identifier (id),
/// the course to which it belongs (courseId), the exam it's part of (examId),
/// the text of the question (questionText), an optional correct answer (correctAnswer),
/// and a list of possible choices for the question (choices).
class ExamQuestion extends Equatable {
  /// Creates an `ExamQuestion` instance with the provided details.
  ///
  /// - [id]: The unique identifier for the exam question.
  /// - [courseId]: The identifier of the course to which the exam question belongs.
  /// - [examId]: The identifier of the exam to which the question is associated.
  /// - [questionText]: The text of the exam question.
  /// - [choices]: A list of possible choices for the question.
  /// - [correctAnswer]: An optional correct answer for the question.
  const ExamQuestion({
    required this.id,
    required this.courseId,
    required this.examId,
    required this.questionText,
    required this.choices,
    this.correctAnswer,
  });

  /// Creates an empty `ExamQuestion` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `ExamQuestion` object.
  const ExamQuestion.empty()
      : this(
          id: 'Test String',
          examId: 'Test String',
          courseId: 'Test String',
          questionText: 'Test String',
          choices: const [],
        );

  /// The unique identifier for the exam question.
  final String id;

  /// The identifier of the course to which the exam question belongs.
  final String courseId;

  /// The identifier of the exam to which the question is associated.
  final String examId;

  /// The text of the exam question.
  final String questionText;

  /// An optional correct answer for the question.
  final String? correctAnswer;

  /// A list of possible choices for the question.
  final List<QuestionChoice> choices;

  @override
  List<Object?> get props => [id, examId, courseId];
}
