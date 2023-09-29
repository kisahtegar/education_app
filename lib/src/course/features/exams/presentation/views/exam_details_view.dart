import 'package:education_app/core/common/widgets/course_info_tile.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `ExamDetailsView` widget displays the details of a specific exam.
///
/// This widget provides a detailed view of the selected exam, including its
/// title, description, time limit, and number of questions. Users can start the
/// exam if questions are available. It also allows users to go back to the
/// previous screen.
class ExamDetailsView extends StatefulWidget {
  /// Creates an `ExamDetailsView` with the specified [exam].
  ///
  /// The [exam] parameter represents the exam for which details will be
  /// displayed.
  const ExamDetailsView(this.exam, {super.key});

  /// The route name used for navigation.
  static const routeName = '/exam-details';

  /// The exam for which details will be displayed.
  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  /// The complete exam that includes additional data such as questions.
  late Exam completeExam;

  /// Fetches the questions related to the current exam.
  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    completeExam = widget.exam;
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.exam.title)),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is ExamQuestionsLoaded) {
              completeExam = (completeExam as ExamModel).copyWith(
                questions: state.questions,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colours.physicsTileColour,
                              ),
                              child: Center(
                                child: completeExam.imageUrl != null
                                    ? Image.network(
                                        completeExam.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.test,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            completeExam.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            completeExam.description,
                            style: const TextStyle(
                              color: Colours.neutralTextColour,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CourseInfoTile(
                            image: MediaRes.examTime,
                            title:
                                '${completeExam.timeLimit.displayDurationLong}'
                                ' for the test.',
                            subtitle: 'Complete the test in '
                                '${completeExam.timeLimit.displayDurationLong}',
                          ),
                          if (state is ExamQuestionsLoaded) ...[
                            const SizedBox(height: 10),
                            CourseInfoTile(
                              image: MediaRes.examQuestions,
                              title: '${completeExam.questions?.length} '
                                  'Questions',
                              subtitle: 'This test consists of '
                                  '${completeExam.questions?.length} questions',
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state is GettingExamQuestions)
                      const Center(child: LinearProgressIndicator())
                    else if (state is ExamQuestionsLoaded)
                      RoundedButton(
                        label: 'Start Exam',
                        onPressed: () {
                          // Navigator.pushNamed(
                          //   context,
                          //   ExamView.routeName,
                          //   arguments: completeExam,
                          // );
                        },
                      )
                    else
                      Text(
                        'No Questions for this exam',
                        style: context.theme.textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
