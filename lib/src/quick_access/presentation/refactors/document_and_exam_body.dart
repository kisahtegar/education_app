import 'package:education_app/core/common/widgets/course_tile.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/views/course_exams_view.dart';
import 'package:education_app/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:education_app/src/course/features/materials/presentation/views/course_materials_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `DocumentAndExamBody` widget is used to display a list of courses as
/// tiles that the user can interact with. Depending on the selected tab (index)
/// it can either navigate to the course materials view or the course exams view
/// when a course tile is tapped.
///
/// Example:
///
/// ```dart
/// DocumentAndExamBody(
///   courses: courseList,
///   index: selectedTabIndex,
/// )
/// ```
class DocumentAndExamBody extends StatelessWidget {
  /// Creates a `DocumentAndExamBody` widget.
  const DocumentAndExamBody({
    required this.courses,
    required this.index,
    super.key,
  });

  /// A list of [Course] objects to be displayed.
  final List<Course> courses;

  /// An integer representing the selected tab index (0 for materials, 1 for
  /// exams).
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20).copyWith(top: 0),
      children: [
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 40,
            runAlignment: WrapAlignment.spaceEvenly,
            children: courses.map((course) {
              return CourseTile(
                course: course,
                onTap: () {
                  context.push(
                    index == 0
                        ? BlocProvider(
                            create: (_) => sl<MaterialCubit>(),
                            child: CourseMaterialsView(course),
                          )
                        : BlocProvider(
                            create: (_) => sl<ExamCubit>(),
                            child: CourseExamsView(course),
                          ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
