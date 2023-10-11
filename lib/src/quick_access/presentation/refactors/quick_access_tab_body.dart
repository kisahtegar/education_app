import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'package:education_app/src/quick_access/presentation/refactors/document_and_exam_body.dart';
import 'package:education_app/src/quick_access/presentation/refactors/exam_history_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// The `QuickAccessTabBody` widget displays the content based on the selected
/// tab index within the Quick Access tab.
///
/// It dynamically switches between different content categories based on the
/// selected tab index:
/// - Document and Exam
/// - Exam History
///
/// The content displayed depends on the selected tab. It fetches course data
/// and exam history based on the selected tab.
///
/// Example:
///
/// ```dart
/// QuickAccessTabBody()
/// ```
class QuickAccessTabBody extends StatefulWidget {
  /// Creates a `QuickAccessTabBody` widget.
  const QuickAccessTabBody({super.key});

  @override
  State<QuickAccessTabBody> createState() => _QuickAccessTabBodyState();
}

class _QuickAccessTabBodyState extends State<QuickAccessTabBody> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if ((state is CoursesLoaded && state.courses.isEmpty) ||
            state is CourseError) {
          return const NotFoundText(
            'No courses found\nPlease contact admin or if you are admin, '
            'add courses',
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );
          return Consumer<QuickAccessTabController>(
            builder: (_, controller, __) {
              switch (controller.currentIndex) {
                case 0:
                case 1:
                  return DocumentAndExamBody(
                    courses: courses,
                    index: controller.currentIndex,
                  );
                default:
                  return BlocProvider(
                    create: (_) => sl<ExamCubit>(),
                    child: const ExamHistoryBody(),
                  );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
