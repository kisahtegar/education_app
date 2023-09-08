import 'package:equatable/equatable.dart';

/// The `Video` class represents a video resource within an educational course.
///
/// A video typically includes details such as its unique identifier (id),
/// the URL where the video is hosted (videoURL), the course to which it belongs
/// (courseId), the date it was uploaded (uploadDate), an optional thumbnail
/// image associated with the video (thumbnail), whether the thumbnail is a
/// file or a URL (thumbnailIsFile), an optional title for the video (title),
/// and the name of the tutor who created the video (tutor).
///
/// This class extends `Equatable` to facilitate easy comparison between
/// `Video` objects based on their unique identifiers.
class Video extends Equatable {
  /// Creates a `Video` instance with the provided details.
  ///
  /// - [id]: The unique identifier for the video.
  /// - [videoURL]: The URL where the video is hosted.
  /// - [courseId]: The identifier of the course to which the video belongs.
  /// - [uploadDate]: The date when the video was uploaded.
  /// - [thumbnail]: An optional thumbnail image associated with the video.
  /// - [thumbnailIsFile]: A flag indicating whether the thumbnail is a file.
  /// - [title]: An optional title for the video.
  /// - [tutor]: The name of the tutor who created the video.
  const Video({
    required this.id,
    required this.videoURL,
    required this.courseId,
    required this.uploadDate,
    this.thumbnail,
    this.thumbnailIsFile = false,
    this.title,
    this.tutor,
  });

  /// Creates an empty `Video` instance with default values.
  ///
  /// This constructor is often used as a placeholder or to initialize an
  /// empty `Video` object.
  Video.empty()
      : this(
          id: '_empty.id',
          videoURL: '_empty.videoURL',
          uploadDate: DateTime.now(),
          courseId: '_empty.courseId',
        );

  /// The unique identifier for the video.
  final String id;

  /// The URL where the video is hosted.
  final String videoURL;

  /// The identifier of the course to which the video belongs.
  final String courseId;

  /// The date when the video was uploaded.
  final DateTime uploadDate;

  /// An optional thumbnail image associated with the video.
  final String? thumbnail;

  /// A flag indicating whether the thumbnail is a file.
  final bool thumbnailIsFile;

  /// An optional title for the video.
  final String? title;

  /// The name of the tutor who created the video.
  final String? tutor;

  @override
  List<Object?> get props => [id];
}
