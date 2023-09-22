// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice.dart';

/// A concrete implementation of the [UserChoice] entity representing a user's
/// choice for a question in an exam.
class UserChoiceModel extends UserChoice {
  /// Constructs a [UserChoiceModel] instance with the specified attributes.
  ///
  /// - [questionId] is the unique identifier of the question.
  /// - [correctChoice] is the identifier of the correct choice for the question.
  /// - [userChoice] is the identifier of the choice made by the user.
  const UserChoiceModel({
    required super.questionId,
    required super.correctChoice,
    required super.userChoice,
  });

  /// Creates an empty [UserChoiceModel] instance for testing purposes.
  const UserChoiceModel.empty()
      : this(
          questionId: 'Test String',
          correctChoice: 'Test String',
          userChoice: 'Test String',
        );

  /// Constructs a [UserChoiceModel] instance from a map of data.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   user's choice.
  UserChoiceModel.fromMap(DataMap map)
      : this(
          questionId: map['questionId'] as String,
          correctChoice: map['correctChoice'] as String,
          userChoice: map['userChoice'] as String,
        );

  /// Creates a copy of this [UserChoiceModel] with optional attribute values
  /// changed.
  ///
  /// - [questionId] (optional) is the unique identifier of the question.
  /// - [correctChoice] (optional) is the identifier of the correct choice for
  ///   the question.
  /// - [userChoice] (optional) is the identifier of the choice made by the user.
  UserChoiceModel copyWith({
    String? questionId,
    String? correctChoice,
    String? userChoice,
  }) {
    return UserChoiceModel(
      questionId: questionId ?? this.questionId,
      correctChoice: correctChoice ?? this.correctChoice,
      userChoice: userChoice ?? this.userChoice,
    );
  }

  /// Converts this [UserChoiceModel] instance into a data map.
  ///
  /// The data map includes the [questionId], [correctChoice], and [userChoice]
  /// attributes.
  DataMap toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'correctChoice': correctChoice,
      'userChoice': userChoice,
    };
  }
}
