import 'dart:io';

import 'package:education_app/core/common/widgets/time_tile.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a video tile with information.
class VideoTile extends StatelessWidget {
  /// Creates a [VideoTile] widget.
  ///
  ///- The [video] parameter represents the video information to display.
  ///- The optional [tappable] parameter determines whether the tile is tappable
  ///  to play the video.
  ///- The optional [uploadTimePrefix] parameter defines the prefix for the
  ///  upload time.
  ///- The optional [isFile] parameter indicates whether the video thumbnail is
  ///  a local file.
  const VideoTile(
    this.video, {
    super.key,
    this.tappable = false,
    this.uploadTimePrefix = 'Uploaded',
    this.isFile = false,
  });

  /// The video information to display.
  final Video video;

  /// Determines whether the tile is tappable to play the video.
  final bool tappable;

  /// Indicates whether the video thumbnail is a local file.
  final bool isFile;

  /// Prefix for the upload time.
  final String uploadTimePrefix;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 108,
      child: Row(
        children: [
          GestureDetector(
            onTap: tappable
                ? () => VideoUtils.playVideo(context, video.videoURL)
                : null,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 108,
                  width: 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: video.thumbnail == null
                          ? const AssetImage(MediaRes.thumbnailPlaceholder)
                          : isFile
                              ? FileImage(File(video.thumbnail!))
                              : NetworkImage(video.thumbnail!) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                if (tappable)
                  Container(
                    height: 108,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black.withOpacity(.3),
                    ),
                    child: Center(
                      child: video.videoURL.isYoutubeVideo
                          ? Image.asset(MediaRes.youtube, height: 40)
                          : const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    video.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'By ${video.tutor}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colours.neutralTextColour,
                    ),
                  ),
                ),
                Flexible(
                  child: TimeTile(
                    video.uploadDate,
                    prefixText: uploadTimePrefix,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
