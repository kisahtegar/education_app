import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';

/// A use case responsible for fetching a list of videos for a given course ID.
class GetVideos extends FutureUsecaseWithParams<List<Video>, String> {
  /// Creates an instance of [GetVideos] with the provided video repository.
  ///
  /// - [_repo]: The video repository from which videos will be retrieved.
  const GetVideos(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call(String params) => _repo.getVideos(params);
}
