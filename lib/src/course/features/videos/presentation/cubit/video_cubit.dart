import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get_videos.dart';
import 'package:equatable/equatable.dart';

part 'video_state.dart';

/// The [VideoCubit] manages the state related to video operations.
///
/// This cubit provides methods to add videos and retrieve a list of videos for
/// a specific course.
class VideoCubit extends Cubit<VideoState> {
  VideoCubit({
    required AddVideo addVideo,
    required GetVideos getVideos,
  })  : _addVideo = addVideo,
        _getVideos = getVideos,
        super(const VideoInitial());

  final AddVideo _addVideo;
  final GetVideos _getVideos;

  /// Adds a video to the course and emits corresponding states.
  ///
  /// This method emits [AddingVideo] state while adding a video and
  /// [VideoAdded] state when the video is successfully added. If an error
  /// occurs during the operation, it emits [VideoError] state.
  ///
  /// [video]: The video to be added.
  Future<void> addVideo(Video video) async {
    emit(const AddingVideo());
    final result = await _addVideo(video);
    result.fold(
      (failure) => emit(VideoError(failure.errorMessage)),
      (_) => emit(const VideoAdded()),
    );
  }

  /// Retrieves a list of videos for a specific course.
  ///
  /// This method emits [LoadingVideos] state while fetching videos and
  /// [VideosLoaded] state with the list of videos when the operation is
  /// successful. If an error occurs during the operation, it emits
  /// [VideoError] state.
  ///
  /// [courseId]: The ID of the course for which videos are to be retrieved.
  Future<void> getVideos(String courseId) async {
    emit(const LoadingVideos());
    final result = await _getVideos(courseId);
    result.fold(
      (failure) => emit(VideoError(failure.errorMessage)),
      (videos) => emit(VideosLoaded(videos)),
    );
  }
}
