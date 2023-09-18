// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// The `QuestionChoice` class represents a choice for a multiple-choice question
/// within an exam or assessment.
///
/// Each choice is associated with a specific question (identified by [questionId])
/// and has a unique identifier ([identifier]). The choice also contains the text
/// of the choice's answer ([choiceAnswer]).
class QuestionChoice extends Equatable {
  /// Creates a `QuestionChoice` instance with the provided details.
  ///
  /// - [questionId]: The unique identifier of the question to which the choice belongs.
  /// - [identifier]: The unique identifier for the choice.
  /// - [choiceAnswer]: The text of the choice's answer.
  const QuestionChoice({
    required this.questionId,
    required this.identifier,
    required this.choiceAnswer,
  });

  /// The unique identifier of the question to which the choice belongs.
  final String questionId;

  /// The unique identifier for the choice.
  final String identifier;

  /// The text of the choice's answer.
  final String choiceAnswer;

  @override
  List<Object?> get props => [questionId, identifier, choiceAnswer];
}
