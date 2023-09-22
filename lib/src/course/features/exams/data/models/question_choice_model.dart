import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice.dart';

/// A concrete implementation of the [QuestionChoice] entity representing a
/// choice for a multiple-choice question in an exam.
///
/// This model class provides methods for creating instances of
/// [QuestionChoiceModel] from different sources, including data maps received
/// during upload, and copying instances with optional attribute values changed.
class QuestionChoiceModel extends QuestionChoice {
  /// Constructs a [QuestionChoiceModel] instance with the specified attributes.
  ///
  /// - [questionId] is the unique identifier of the question this choice
  ///   belongs to.
  /// - [identifier] is a unique identifier for this choice.
  /// - [choiceAnswer] is the text representing the choice's answer.
  const QuestionChoiceModel({
    required super.questionId,
    required super.identifier,
    required super.choiceAnswer,
  });

  /// Creates an empty [QuestionChoiceModel] instance for testing purposes.
  const QuestionChoiceModel.empty()
      : this(
          questionId: 'Test String',
          identifier: 'Test String',
          choiceAnswer: 'Test String',
        );

  /// Constructs a [QuestionChoiceModel] instance from a map of data.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   choice.
  QuestionChoiceModel.fromMap(DataMap map)
      : this(
          questionId: map['questionId'] as String,
          identifier: map['identifier'] as String,
          choiceAnswer: map['choiceAnswer'] as String,
        );

  /// Constructs a [QuestionChoiceModel] instance from data received during an
  /// upload.
  ///
  /// - [map] is a data map containing the attributes needed to create the
  ///   choice.
  QuestionChoiceModel.fromUploadMap(DataMap map)
      : this(
          questionId: 'Test String',
          identifier: map['identifier'] as String,
          choiceAnswer: map['Answer'] as String,
        );

  /// Creates a copy of this [QuestionChoiceModel] with optional attribute
  /// values changed.
  ///
  /// - [questionId] (optional) is the unique identifier of the question this
  ///   choice belongs to.
  /// - [identifier] (optional) is a unique identifier for this choice.
  /// - [choiceAnswer] (optional) is the text representing the choice's answer.
  QuestionChoiceModel copyWith({
    String? questionId,
    String? identifier,
    String? choiceAnswer,
  }) {
    return QuestionChoiceModel(
      questionId: questionId ?? this.questionId,
      identifier: identifier ?? this.identifier,
      choiceAnswer: choiceAnswer ?? this.choiceAnswer,
    );
  }

  /// Converts this [QuestionChoiceModel] instance into a data map.
  ///
  /// The data map includes the [questionId], [identifier], and [choiceAnswer]
  /// attributes.
  DataMap toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'identifier': identifier,
      'choiceAnswer': choiceAnswer,
    };
  }
}
