import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';

/// An abstract class defining methods to manage educational video resources.
abstract class VideoRepo {
  const VideoRepo();

  /// Retrieves a list of videos for a specific course.
  ///
  /// - [courseId]: The unique identifier of the course.
  ///
  /// Returns a list of video entities.
  ///
  /// We could make this a stream, but for the sakes of tutorials,
  /// we'll keep it simple
  ResultFuture<List<Video>> getVideos(String courseId);

  /// Adds a new video to the repository.
  ///
  /// - [video]: The video entity to be added.
  ///
  /// Returns the result of the operation.
  ResultFuture<void> addVideo(Video video);
}
