import 'package:education_app/core/common/widgets/course_info_tile.dart';
import 'package:education_app/core/common/widgets/expandable_text.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/videos/presentation/views/course_videos_view.dart';
import 'package:flutter/material.dart';

/// The `CourseDetailsScreen` displays detailed information about a course.
class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen(this.course, {super.key});

  /// The route name for navigating to this screen.
  static const routeName = '/course-details';

  /// The course for which details are displayed.
  final Course course;

  @override
  Widget build(BuildContext context) {
    // override course for testing purposes.
    // final course = (this.course as CourseModel).copyWith(
    //   numberOfVideos: 2,
    //   numberOfExams: 3,
    //   numberOfMaterials: 35,
    // );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(course.title)),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * .3,
                child: Center(
                  child: course.image != null
                      ? Image.network(course.image!)
                      : Image.asset(MediaRes.casualMeditation),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (course.description != null)
                    ExpandableText(context, text: course.description!),
                  if (course.numberOfMaterials > 0 ||
                      course.numberOfVideos > 0 ||
                      course.numberOfExams > 0) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Subject Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoVideo,
                        title: '${course.numberOfVideos} Video(s)',
                        subtitle: 'Watch our tutorial '
                            'videos for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          CourseVideosView.routeName,
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoExam,
                        title: '${course.numberOfExams} Exam(s)',
                        subtitle: 'Take our exams for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaRes.courseInfoMaterial,
                        title: '${course.numberOfMaterials} Material(s)',
                        subtitle: 'Access to '
                            '${course.numberOfMaterials.estimate} materials '
                            'for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed(
                          '/unknown-route',
                          arguments: course,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
