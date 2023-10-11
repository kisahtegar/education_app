import 'package:education_app/core/res/colours.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice.dart';
import 'package:flutter/material.dart';

/// The `ExamHistoryAnswerTile` widget is used to display individual answer
/// details for a specific question in the exam history. It provides information
/// about the question index, whether the answer is correct or wrong, and the
/// user's chosen answer.
///
/// Example:
///
/// ```dart
/// ExamHistoryAnswerTile(
///   answer: userAnswer,
///   index: 1,
/// )
/// ```
class ExamHistoryAnswerTile extends StatelessWidget {
  /// Creates an `ExamHistoryAnswerTile` widget.
  const ExamHistoryAnswerTile(this.answer, {required this.index, super.key});

  /// A [UserChoice] object representing the answer details.
  final UserChoice answer;

  /// An integer representing the question index.
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        'Question $index',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        answer.isCorrect ? 'Right' : 'Wrong',
        style: TextStyle(
          color: answer.isCorrect ? Colours.greenColour : Colours.redColour,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Text(
          'Your Answer: ${answer.userChoice}',
          style: TextStyle(
            color: answer.isCorrect ? Colours.greenColour : Colours.redColour,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
