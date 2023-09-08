import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.dart';
import 'package:education_app/src/course/features/videos/domain/repos/video_repo.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video_repo.mock.dart';

void main() {
  // Create mocks for dependencies
  late VideoRepo repo;
  late AddVideo usecase;

  // Create a sample empty Video instance
  final tVideo = Video.empty();

  // Set up the test environment
  setUp(() {
    repo = MockVideoRepo();
    usecase = AddVideo(repo);

    // Register the fallback value for the mock
    registerFallbackValue(tVideo);
  });

  test('should call [VideoRepo.addVideo]', () async {
    // Mock the behavior of [VideoRepo.addVideo]
    when(() => repo.addVideo(any())).thenAnswer((_) async => const Right(null));

    // Execute the use case
    final result = await usecase(tVideo);

    // Expect a successful result
    expect(result, equals(const Right<dynamic, void>(null)));
    // Verify that [VideoRepo.addVideo] was called once with the sample video
    verify(() => repo.addVideo(tVideo)).called(1);
    // Verify that there are no more interactions with the repository
    verifyNoMoreInteractions(repo);
  });
}
