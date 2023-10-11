// ignore_for_file: comment_references

import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/app/providers/exam_controller.dart';
import 'package:education_app/src/course/features/exams/presentation/widgets/exam_navigation_blob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// The `ExamView` widget displays an exam interface with questions and control.
///
/// It provides a user interface for answering exam questions and includes
/// navigation buttons to move between questions. Users can submit the exam
/// before the time limit expires. The widget also handles exam submission.
///
/// This widget depends on the [ExamController] for managing exam-related data
/// and [ExamCubit] for handling exam state and submission.
class ExamView extends StatefulWidget {
  const ExamView({super.key});

  static const routeName = '/exam';

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool showingLoader = false;

  late ExamController examController;

  /// Initiates the process of submitting the exam.
  ///
  /// If the exam is not yet completed, it prompts the user to confirm their
  /// intent to submit the exam. The remaining time is displayed in minutes,
  /// hours, or seconds, depending on the time left. If the user confirms,
  /// [collectAndSend] is called to send the exam to the server. If the user
  /// cancels, the exam timer is resumed.
  Future<void> submitExam() async {
    if (!examController.isTimeUp) {
      // If the exam time is not yet up.
      examController.stopTimer(); // Stop the exam timer.

      // Determine whether there are minutes, hours, or seconds left before the
      // exam submission deadline.
      final isMinutesLeft = examController.remainingTimeInSeconds > 60;
      final isHoursLeft = examController.remainingTimeInSeconds > 3600;
      final timeLeftText = isHoursLeft
          ? 'hours'
          : isMinutesLeft
              ? 'minutes'
              : 'seconds';

      final endExam = await showDialog<bool>(
        context: context,
        builder: (context) {
          // Display a confirmation dialog to the user.
          return AlertDialog.adaptive(
            title: const Text('Submit Exam?'),
            content: Text(
              'You have ${examController.remainingTime} $timeLeftText left.\n'
              'Are you sure you want to submit?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // If the user cancels, return false.
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // If the user confirms by clicking "Submit," return true.
                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colours.redColour),
                ),
              ),
            ],
          );
        },
      );

      if (endExam ?? false) {
        // If the user confirms their intent to submit.
        return collectAndSend(); // Send the exam to the server.
      } else {
        // If the user cancels, resume the exam timer.
        examController.startTimer();
        return;
      }
    }

    // If the exam time is up, proceed to collect and send the exam.
    collectAndSend();
  }

  /// Collects and sends the user's exam answers to the server.
  ///
  /// This method is called when the user confirms their intent to submit the
  /// exam. It collects the user's answers and exam details and sends them to
  /// the server. The [ExamCubit] is used to submit the exam and manage the
  /// exam submission state.
  void collectAndSend() {
    final exam = examController.userExam;
    context.read<ExamCubit>().submitExam(exam);
  }

  /// Called when the dependencies of this widget have changed.
  ///
  /// In this method, the [context] is used to retrieve the [ExamController]
  /// instance using [context.read<ExamController>()]. [ExamController] is a
  /// provider that manage the state of the exam. The retrieved [ExamController]
  /// instance is assigned to the [examController] variable.
  ///
  /// This method is typically used to handle changes in dependencies or data
  /// sources when the widget is rebuilt. In this case, it ensures that the
  /// [examController] is correctly initialized with the latest context data.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the latest ExamController instance from the context and assign
    // it to examController.
    examController = context.read<ExamController>();
  }

  /// Initializes the state of the [ExamView] widget.
  ///
  /// In this method, the super class's [initState] method is called to perform
  /// any necessary initialization. A [PersistentFrameCallback] is added using
  /// [WidgetsBinding.instance.addPersistentFrameCallback].
  ///
  /// Inside the callback:
  /// - [examController] is assigned an event listener using
  ///   [examController.addListener].
  /// - The event listener checks if the exam time is up by calling
  ///   [examController.isTimeUp].
  /// - If the exam time is up, it triggers the [submitExam] method to initiate
  ///   the exam submission process.
  ///
  /// This setup ensures that when the exam timer reaches zero, the [submitExam]
  /// method is automatically called, allowing the user to submit the exam even
  /// if they don't manually click the "Submit" button.
  @override
  void initState() {
    super.initState();

    // ignore: lines_longer_than_80_chars
    // TODO(kisahtegar): Its still having some issues with uncaught exceptions, Need to be fixed

    // Add a PersistentFrameCallback to listen for frame updates.
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      examController.addListener(() {
        if (examController.isTimeUp) submitExam();
      });
    });
  }

  @override
  void dispose() {
    examController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamController>(
      builder: (_, controller, __) {
        return BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (showingLoader) {
              Navigator.pop(context);
              showingLoader = false;
            }
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is SubmittingExam) {
              CoreUtils.showLoadingDialog(context);
              showingLoader = true;
            } else if (state is ExamSubmitted) {
              CoreUtils.showSnackBar(context, 'Exam Submitted');
              Navigator.pop(context);
            }
          },
          builder: (_, state) => WillPopScope(
            onWillPop: () async {
              if (state is SubmittingExam) return false;
              if (controller.isTimeUp) return true;
              final result = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: const Text('Exit Exam'),
                    content:
                        const Text('Are you sure you want to Exit the exam'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Exit exam'),
                      ),
                    ],
                  );
                },
              );
              return result ?? false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(MediaRes.examTimeRed, height: 30, width: 30),
                    const SizedBox(width: 10),
                    Text(
                      controller.remainingTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colours.redColour,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: submitExam,
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              'Question ${controller.currentIndex + 1}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color(0xFF666E7A),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color(0xFFC4C4C4),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: controller.exam.imageUrl == null
                                    ? Image.asset(
                                        MediaRes.test,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller.exam.imageUrl!,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              controller.currentQuestion.questionText,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.currentQuestion.choices.length,
                              itemBuilder: (_, index) {
                                final choice =
                                    controller.currentQuestion.choices[index];
                                return RadioListTile(
                                  value: choice.identifier,
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: controller.userAnswer?.userChoice,
                                  title: Text(
                                    '${choice.identifier}. '
                                    '${choice.choiceAnswer}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.answer(choice);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const ExamNavigationBlob(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
