// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:equatable/equatable.dart';

/// The `Exam` class represents an exam or assessment within an educational course.
///
/// An exam typically includes details such as its unique identifier (id),
/// the course to which it belongs (courseId), a title describing the exam (title),
/// an optional image URL (imageUrl) for the exam cover, a description providing
/// additional information (description), a time limit (timeLimit) for completing
/// the exam in minutes, and a list of exam questions (questions).
class Exam extends Equatable {
  /// Creates an `Exam` instance with the provided details.
  ///
  /// - [id]: The unique identifier for the exam.
  /// - [courseId]: The identifier of the course to which the exam belongs.
  /// - [title]: A title describing the exam.
  /// - [description]: A information about the exam.
  /// - [timeLimit]: The time limit for completing the exam in minutes.
  /// - [imageUrl]: An optional URL for the exam's cover image.
  /// - [questions]: A list of exam questions.
  const Exam({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.timeLimit,
    this.imageUrl,
    this.questions,
  });

  /// Creates an empty `Exam` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `Exam` object.
  const Exam.empty()
      : this(
          id: 'Test String',
          courseId: 'Test String',
          title: 'Test String',
          description: 'Test String',
          timeLimit: 0,
          questions: const [],
        );

  /// The unique identifier for the exam.
  final String id;

  /// The identifier of the course to which the exam belongs.
  final String courseId;

  /// A title describing the exam.
  final String title;

  /// Information about the exam.
  final String description;

  /// The time limit for completing the exam in minutes.
  final int timeLimit;

  /// An optional URL for the exam's cover image.
  final String? imageUrl;

  /// A list of exam questions associated with the exam.
  final List<ExamQuestion>? questions;

  @override
  List<Object?> get props => [id, courseId];

  /// This method is overridden to provide a human-readable representation of
  /// the `Exam` instance.
  @override
  String toString() {
    return 'Exam{id:  $id, courseId: $courseId, title: $title, description: $description, '
        'timeLimit: $timeLimit, imageUrl: $imageUrl, questions: $questions}';
  }
}
