import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/src/quick_access/presentation/views/exam_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

/// The `ExamHistoryTile` widget is used to display a tile representing a user's
/// completed exam history. It provides information about the exam, its
/// completion progress, and an optional navigation feature to view more
/// details.
///
/// Example:
///
/// ```dart
/// ExamHistoryTile(
///   exam: userExam,
///   navigateToDetails: true,
/// )
/// ```
class ExamHistoryTile extends StatelessWidget {
  /// Creates an `ExamHistoryTile` widget.
  const ExamHistoryTile(
    this.exam, {
    super.key,
    this.navigateToDetails = true,
  });

  /// The [UserExam] object representing the exam to display.
  final UserExam exam;

  /// A boolean value indicating whether tapping on the tile should navigate to
  /// the exam details screen.
  final bool navigateToDetails;

  @override
  Widget build(BuildContext context) {
    final answeredQuestionsPercentage =
        exam.answers.length / exam.totalQuestions;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: navigateToDetails
          ? () => Navigator.of(context).pushNamed(
                ExamHistoryDetailsScreen.routeName,
                arguments: exam,
              )
          : null,
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: Colours.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: exam.examImageUrl == null
                ? Image.asset(MediaRes.test)
                : Image.network(exam.examImageUrl!),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exam.examTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You have completed',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: '${exam.answers.length}/${exam.totalQuestions} ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: answeredQuestionsPercentage < .5
                          ? Colours.redColour
                          : Colours.greenColour,
                    ),
                    children: const [
                      TextSpan(
                        text: 'questions',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          CircularStepProgressIndicator(
            totalSteps: exam.totalQuestions,
            currentStep: exam.answers.length,
            selectedColor: answeredQuestionsPercentage < .5
                ? Colours.redColour
                : Colours.greenColour,
            padding: 0,
            width: 60,
            height: 60,
            child: Center(
              child: Text(
                '${(answeredQuestionsPercentage * 100).toInt()}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: answeredQuestionsPercentage < .5
                      ? Colours.redColour
                      : Colours.greenColour,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
