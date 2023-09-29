import 'package:chewie/chewie.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A view for playing videos using the Chewie video player.
class VideoPlayerView extends StatefulWidget {
  /// Constructs a [VideoPlayerView] with the specified video URL.
  ///
  /// The [videoURL] parameter is required and represents the URL of the video
  /// to play.
  const VideoPlayerView({required this.videoURL, super.key});

  /// The route name for this view.
  static const routeName = '/video-player';

  /// The URL of the video to play.
  final String videoURL;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  /// Initializes the video player and Chewie controller.
  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    await videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  /// Creates a Chewie controller for the video player.
  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      hideControlsTimer: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const NestedBackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
