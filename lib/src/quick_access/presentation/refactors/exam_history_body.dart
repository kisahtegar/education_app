import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education_app/src/quick_access/presentation/widgets/exam_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `ExamHistoryBody` widget is used to display a user's exam history. It
/// loads the user's completed exams, sorts them by submission date, and display
/// them as a list of `ExamHistoryTile` widgets. It also handles loading states
/// and errors.
///
/// Example:
///
/// ```dart
/// ExamHistoryBody()
/// ```
class ExamHistoryBody extends StatefulWidget {
  /// Creates an `ExamHistoryBody` widget.
  const ExamHistoryBody({super.key});

  @override
  State<ExamHistoryBody> createState() => _ExamHistoryBodyState();
}

class _ExamHistoryBodyState extends State<ExamHistoryBody> {
  /// Retrieves the user's exam history.
  void getHistory() {
    context.read<ExamCubit>().getUserExams();
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (_, state) {
        if (state is ExamError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is GettingUserExams) {
          return const LoadingView();
        } else if ((state is UserExamsLoaded && state.exams.isEmpty) ||
            state is ExamError) {
          return const NotFoundText('No exams completed yet');
        } else if (state is UserExamsLoaded) {
          final exams = state.exams
            ..sort(
              (a, b) => b.dateSubmitted.compareTo(a.dateSubmitted),
            );
          return ListView.builder(
            itemCount: exams.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) {
              final exam = exams[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExamHistoryTile(exam),
                  if (index != exams.length - 1) const SizedBox(height: 20),
                ],
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
