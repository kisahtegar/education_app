import 'dart:async';

import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/presentation/views/video_player_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_metadata/youtube.dart';

/// Utility class for handling video-related operations.
class VideoUtils {
  const VideoUtils._();

  /// Fetches video metadata from a YouTube URL.
  ///
  /// This method retrieves video information such as thumbnail, title, and
  /// tutor from the provided YouTube URL.
  ///
  /// Parameters:
  /// - `context`: The current [BuildContext] for displaying messages.
  /// - `url`: The YouTube URL to fetch metadata from.
  ///
  /// Returns a [Video] object if successful, or null if there was an error.
  ///
  /// If any of the required metadata (thumbnail, title, authorName) is missing,
  /// it displays an error message and returns null.
  static Future<Video?> getVideoFromYT(
    BuildContext context, {
    required String url,
  }) async {
    // Helper function to display a Snackbar message.
    void showSnack(String message) => CoreUtils.showSnackBar(context, message);

    try {
      // Fetch video metadata from the YouTube URL.
      final metadata = await YoutubeMetaData.getData(url);

      // Check if essential metadata is missing.
      if (metadata.thumbnailUrl == null ||
          metadata.title == null ||
          metadata.authorName == null) {
        final missingData = <String>[];
        if (metadata.thumbnailUrl == null) missingData.add('Thumbnail');
        if (metadata.title == null) missingData.add('Title');
        if (metadata.authorName == null) missingData.add('AuthorName');

        // Construct an error message with missing data.
        var missingDataText = missingData
            .fold(
              '',
              (previousValue, element) => '$previousValue$element, ',
            )
            .trim();
        missingDataText =
            missingDataText.substring(0, missingDataText.length - 1);
        final message = 'Could not get video data. Please try again.\n'
            'The following data is missing: $missingDataText';

        // Display the error message and return null.
        showSnack(message);
        return null;
      }

      // Create a Video object with the retrieved metadata.
      return VideoModel.empty().copyWith(
        thumbnail: metadata.thumbnailUrl,
        videoURL: url,
        title: metadata.title,
        tutor: metadata.authorName,
      );
    } catch (e) {
      // Handle exceptions and display an error message.
      showSnack('PLEASE TRY AGAIN\n$e');
      return null;
    }
  }

  /// Plays a video.
  ///
  /// This method launches the video either in an external application (for
  /// YouTube) or in the built-in video player view (for other video URLs).
  ///
  /// Parameters:
  /// - `context`: The current [BuildContext].
  /// - `videoURL`: The URL of the video to play.
  static Future<void> playVideo(BuildContext context, String videoURL) async {
    final navigator = Navigator.of(context);

    // Check if the video URL is a YouTube video.
    if (videoURL.isYoutubeVideo) {
      // Launch the YouTube video in an external application.
      if (!await launchUrl(
        Uri.parse(videoURL),
        mode: LaunchMode.externalApplication,
      )) {
        // Display an error message if the launch fails.
        CoreUtils.showSnackBar(
          context,
          'Could not launch $videoURL',
        );
      }
    } else {
      // Open the video in the built-in video player view.
      unawaited(
        navigator.pushNamed(
          VideoPlayerView.routeName,
          arguments: videoURL,
        ),
      );
    }
  }
}
