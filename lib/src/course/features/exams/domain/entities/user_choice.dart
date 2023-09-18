// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';

/// The `UserChoice` class represents a user's choice for a particular exam question.
///
/// A user choice typically includes details such as the identifier of the question
/// for which the choice is made (questionId), the user's selected choice (userChoice),
/// and the correct choice for the question (correctChoice). It also provides a method
/// `isCorrect` to determine whether the user's choice matches the correct choice.
class UserChoice extends Equatable {
  /// Creates a `UserChoice` instance with the provided details.
  ///
  /// - [userChoice]: The user's selected choice for the question.
  /// - [questionId]: The identifier of the question for which the choice is made.
  /// - [correctChoice]: The correct choice for the question.
  const UserChoice({
    required this.userChoice,
    required this.questionId,
    required this.correctChoice,
  });

  /// Creates an empty `UserChoice` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `UserChoice` object.
  const UserChoice.empty()
      : this(
          questionId: 'Test String',
          correctChoice: 'Test String',
          userChoice: 'Test String',
        );

  /// The user's selected choice for the question.
  final String userChoice;

  /// The identifier of the question for which the choice is made.
  final String questionId;

  /// The correct choice for the question.
  final String correctChoice;

  /// Determines whether the user's choice matches the correct choice.
  bool get isCorrect => userChoice == correctChoice;

  @override
  List<Object?> get props => [questionId, userChoice];
}
