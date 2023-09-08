// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';

/// A concrete implementation of the [Video] entity, representing a video resource.
class VideoModel extends Video {
  /// Creates an instance of [VideoModel] with the provided properties.
  ///
  /// - [id]: The unique identifier for the video.
  /// - [thumbnail]: The URL or file path to the video's thumbnail image.
  /// - [videoURL]: The URL or file path to the video resource.
  /// - [title]: The title or name of the video.
  /// - [tutor]: The name of the tutor or creator of the video.
  /// - [courseId]: The unique identifier of the course to which the video belongs.
  /// - [uploadDate]: The date and time when the video was uploaded.
  /// - [thumbnailIsFile]: A flag indicating whether the thumbnail is a local
  ///   file (true) or a URL (false).
  const VideoModel({
    required super.id,
    required super.videoURL,
    required super.courseId,
    required super.uploadDate,
    super.thumbnail,
    super.thumbnailIsFile = false,
    super.title,
    super.tutor,
  });

  /// Creates an empty [VideoModel] instance with default placeholder values.
  ///
  /// This constructor is often used for initializing new video objects.
  VideoModel.empty()
      : this(
          id: '_empty.id',
          videoURL: '_empty.videoURL',
          uploadDate: DateTime.now(),
          courseId: '_empty.courseId',
        );

  /// Creates a [VideoModel] instance from a map representation of video data.
  ///
  /// - [map]: A map containing video data, typically retrieved from a data source.
  VideoModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          videoURL: map['videoURL'] as String,
          courseId: map['courseId'] as String,
          uploadDate: (map['uploadDate'] as Timestamp).toDate(),
          thumbnail: map['thumbnail'] as String?,
          title: map['title'] as String?,
          tutor: map['tutor'] as String?,
        );

  /// Creates a copy of this [VideoModel] with updated properties.
  ///
  /// This method is useful for making modifications to an existing video object.
  VideoModel copyWith({
    String? id,
    String? thumbnail,
    String? videoURL,
    String? title,
    String? tutor,
    String? courseId,
    DateTime? uploadDate,
    bool? thumbnailIsFile,
  }) {
    return VideoModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      videoURL: videoURL ?? this.videoURL,
      title: title ?? this.title,
      tutor: tutor ?? this.tutor,
      courseId: courseId ?? this.courseId,
      uploadDate: uploadDate ?? this.uploadDate,
      thumbnailIsFile: thumbnailIsFile ?? this.thumbnailIsFile,
    );
  }

  /// Converts this [VideoModel] instance to a map for storage or serialization.
  ///
  /// The resulting map can be easily converted back to a [VideoModel] using
  /// the [VideoModel.fromMap] constructor.
  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'tutor': tutor,
      'courseId': courseId,
      'thumbnail': thumbnail,
      'videoURL': videoURL,
      'uploadDate': FieldValue.serverTimestamp(),
    };
  }
}
