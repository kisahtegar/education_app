// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_src.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';

/// Implementation of the [VideoRepo] interface responsible for interacting
/// with video-related data from a remote data source.
///
/// This class handles adding videos and retrieving a list of videos associated
/// with a specific course.
class VideoRepoImpl implements VideoRepo {
  /// Constructs a [VideoRepoImpl] instance with the provided [VideoRemoteDataSrc].
  const VideoRepoImpl(this._remoteDataSrc);

  /// The remote data source for video-related operations.
  final VideoRemoteDataSrc _remoteDataSrc;

  /// Adds a new video to the remote data source.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  /// - If the video is added successfully, returns [Right(null)].
  /// - If an error occurs during the operation, returns [Left] with a [ServerFailure].
  @override
  ResultFuture<void> addVideo(Video video) async {
    try {
      await _remoteDataSrc.addVideo(video);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a list of videos associated with the specified course.
  ///
  /// Returns a [ResultFuture] containing the list of videos on success or a
  /// [ServerFailure] on failure.
  @override
  ResultFuture<List<Video>> getVideos(String courseId) async {
    try {
      final result = await _remoteDataSrc.getVideos(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
