import 'package:education_app/core/common/widgets/course_picker.dart';
import 'package:education_app/core/common/widgets/info_field.dart';
import 'package:education_app/core/common/widgets/reactive_button.dart';
import 'package:education_app/core/common/widgets/video_tile.dart';
import 'package:education_app/core/enums/notification_enum.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

/// A view for adding a new video to a course.
class AddVideoView extends StatefulWidget {
  const AddVideoView({super.key});

  /// The route name for this view.
  static const routeName = '/add-video';

  @override
  State<AddVideoView> createState() => _AddVideoViewState();
}

class _AddVideoViewState extends State<AddVideoView> {
  // Controller
  final urlController = TextEditingController();
  final authorController = TextEditingController(text: 'dbestech');
  final titleController = TextEditingController();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  // Global Key
  final formKey = GlobalKey<FormState>();

  // Model
  VideoModel? video;
  PreviewData? previewData;

  final authorFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final urlFocusNode = FocusNode();

  bool getMoreDetails = false;

  bool get isYoutube => urlController.text.trim().isYoutubeVideo;

  bool thumbNailIsFile = false;
  bool loading = false;
  bool showingDialog = false;

  /// Resets the state of the view, clearing input fields and resetting flags.
  void reset() {
    setState(() {
      urlController.clear();
      authorController.text = 'dbestech';
      titleController.clear();
      getMoreDetails = false;
      loading = false;
      video = null;
      previewData = null;
    });
  }

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      if (urlController.text.trim().isEmpty) reset();
    });
    authorController.addListener(() {
      video = video?.copyWith(tutor: authorController.text.trim());
    });
    titleController.addListener(() {
      video = video?.copyWith(title: titleController.text.trim());
    });
  }

  /// Fetches video details based on the provided URL.
  Future<void> fetchVideo() async {
    // Check if the provided URL is empty, if so, return.
    if (urlController.text.trim().isEmpty) return;

    // Unfocus the input field to dismiss the keyboard.
    FocusManager.instance.primaryFocus?.unfocus();

    // Reset flags and states for loading and video details.
    setState(() {
      getMoreDetails = false;
      loading = false;
      thumbNailIsFile = false;
      video = null;
      previewData = null;
    });

    // Set the loading flag to true to indicate that video details are being
    // fetched.
    setState(() {
      loading = true;
    });

    // Check if the provided URL is a valid YouTube URL.
    if (isYoutube) {
      // Fetch video details using the VideoUtils.getVideoFromYT method.
      video = await VideoUtils.getVideoFromYT(
        context,
        url: urlController.text.trim(),
      ) as VideoModel?;

      // Set the loading flag to false to indicate that video details have been
      // fetched.
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    urlController.dispose();
    authorController.dispose();
    titleController.dispose();
    courseController.dispose();
    courseNotifier.dispose();
    urlFocusNode.dispose();
    titleFocusNode.dispose();
    authorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        Navigator.of(context).pop();
      },
      child: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) {
          if (showingDialog == true) {
            Navigator.pop(context);
            showingDialog = false;
          }
          if (state is AddingVideo) {
            CoreUtils.showLoadingDialog(context);
            showingDialog = true;
          } else if (state is VideoError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is VideoAdded) {
            CoreUtils.showSnackBar(context, 'Video added successfully');
            CoreUtils.sendNotification(
              context,
              title: 'New ${courseNotifier.value!.title} video',
              body: 'A new video has been added for '
                  '${courseNotifier.value!.title}',
              category: NotificationCategory.VIDEO,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Add Video')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Form(
                key: formKey,
                child: CoursePicker(
                  controller: courseController,
                  notifier: courseNotifier,
                ),
              ),
              const SizedBox(height: 20),
              InfoField(
                controller: urlController,
                hintText: 'Enter video URL',
                onEditingComplete: fetchVideo,
                focusNode: urlFocusNode,
                onTapOutside: (_) => urlFocusNode.unfocus(),
                autoFocus: true,
                keyboardType: TextInputType.url,
              ),
              ListenableBuilder(
                listenable: urlController,
                builder: (_, __) {
                  return Column(
                    children: [
                      if (urlController.text.trim().isNotEmpty) ...[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: fetchVideo,
                          child: const Text('Fetch Video'),
                        ),
                      ],
                    ],
                  );
                },
              ),
              if (loading && !isYoutube)
                LinkPreview(
                  onPreviewDataFetched: (data) async {
                    setState(() {
                      thumbNailIsFile = false;
                      video = VideoModel.empty().copyWith(
                        thumbnail: data.image?.url,
                        videoURL: urlController.text.trim(),
                        title: data.title ?? 'No title',
                      );
                      if (data.image?.url != null) loading = false;
                      getMoreDetails = true;
                      titleController.text = data.title ?? '';
                      loading = false;
                    });
                  },
                  previewData: previewData,
                  text: '',
                  width: 0,
                ),
              if (video != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: VideoTile(
                    video!,
                    isFile: thumbNailIsFile,
                    uploadTimePrefix: '~',
                  ),
                ),
              if (getMoreDetails) ...[
                InfoField(
                  controller: authorController,
                  keyboardType: TextInputType.name,
                  autoFocus: true,
                  focusNode: authorFocusNode,
                  labelText: 'Tutor Name',
                  onEditingComplete: () {
                    setState(() {});
                    titleFocusNode.requestFocus();
                  },
                ),
                InfoField(
                  controller: titleController,
                  labelText: 'Video Title',
                  focusNode: titleFocusNode,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: ReactiveButton(
                  disabled: video == null,
                  loading: loading,
                  text: 'Submit',
                  onPressed: () {
                    // If the [video] is not null, but the video.tutor is null,
                    // then we check if the authorName field is not empty, if it
                    // is not empty, we set the video.tutor to become the value
                    // of the authorName controller.
                    if (formKey.currentState!.validate()) {
                      if (courseNotifier.value == null) {
                        CoreUtils.showSnackBar(context, 'Please Pick a course');
                        return;
                      }
                      if (courseNotifier.value != null &&
                          video != null &&
                          video!.tutor == null &&
                          authorController.text.trim().isNotEmpty) {
                        video = video!.copyWith(
                          tutor: authorController.text.trim(),
                        );
                      }
                      if (video != null &&
                          video!.tutor != null &&
                          video!.title != null &&
                          video!.title!.isNotEmpty) {
                        video = video?.copyWith(
                          thumbnailIsFile: thumbNailIsFile,
                          courseId: courseNotifier.value!.id,
                          uploadDate: DateTime.now(),
                        );
                        context.read<VideoCubit>().addVideo(video!);
                      } else {
                        CoreUtils.showSnackBar(
                          context,
                          'Please Fill all fields',
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
