part of 'video_cubit.dart';

/// The [VideoState] represents the state of video-related operations.
sealed class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of video operations.
final class VideoInitial extends VideoState {
  const VideoInitial();
}

/// Indicates that a video is being added.
final class AddingVideo extends VideoState {
  const AddingVideo();
}

/// Indicates that videos are being loaded.
final class LoadingVideos extends VideoState {
  const LoadingVideos();
}

/// Indicates that a video has been successfully added.
final class VideoAdded extends VideoState {
  const VideoAdded();
}

/// Represents the state when videos have been successfully loaded.
final class VideosLoaded extends VideoState {
  const VideosLoaded(this.videos);

  final List<Video> videos;

  @override
  List<Object> get props => [videos];
}

/// Represents the state when an error occurs during video operations.
final class VideoError extends VideoState {
  const VideoError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
