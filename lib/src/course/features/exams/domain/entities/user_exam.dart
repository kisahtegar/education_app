// ignore_for_file: lines_longer_than_80_chars

// users >> userId >> courses >> courseId >> exams >> examId >> answer

import 'package:education_app/src/course/features/exams/domain/entities/user_choice.dart';
import 'package:equatable/equatable.dart';

/// The `UserExam` class represents a user's attempt at an educational exam.
///
/// A user exam includes details such as the unique identifier of the exam (examId),
/// the identifier of the course to which the exam belongs (courseId), the total number
/// of questions in the exam (totalQuestions), the title of the exam (examTitle), the URL
/// of an image associated with the exam (examImageUrl), the date when the exam was
/// submitted (dateSubmitted), and a list of user choices (answers) for each question
/// in the exam.
///
/// This class is designed to allow fetching the actual exam questions by using the [examId]
/// and then displaying the user's answers.
///
/// So the plan is, even when we want to display the user's exam history, we
/// can fetch the actual exam by the [examId] and then display the questions.
class UserExam extends Equatable {
  /// Creates a `UserExam` instance with the provided details.
  ///
  /// - [examId]: The unique identifier of the exam.
  /// - [courseId]: The identifier of the course to which the exam belongs.
  /// - [totalQuestions]: The total number of questions in the exam.
  /// - [examTitle]: The title of the exam.
  /// - [examImageUrl]: The URL of an image associated with the exam.
  /// - [dateSubmitted]: The date when the exam was submitted.
  /// - [answers]: A list of user choices for each question in the exam.
  const UserExam({
    required this.examId,
    required this.courseId,
    required this.totalQuestions,
    required this.examTitle,
    required this.dateSubmitted,
    required this.answers,
    this.examImageUrl,
  });

  /// Creates an empty `UserExam` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `UserExam` object.
  UserExam.empty([DateTime? date])
      : this(
          examId: 'Test String',
          courseId: 'Test String',
          totalQuestions: 0,
          examTitle: 'Test String',
          examImageUrl: 'Test String',
          dateSubmitted: date ?? DateTime.now(),
          answers: const [],
        );

  /// The unique identifier of the exam.
  final String examId;

  /// The identifier of the course to which the exam belongs.
  final String courseId;

  /// The total number of questions in the exam.
  final int totalQuestions;

  /// The title of the exam.
  final String examTitle;

  /// The URL of an image associated with the exam.
  final String? examImageUrl;

  /// The date when the exam was submitted.
  final DateTime dateSubmitted;

  /// A list of user choices for each question in the exam.
  final List<UserChoice> answers;

  @override
  List<Object?> get props => [examId, courseId];
}
