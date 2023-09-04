import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CacheFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CacheFirstTimer(repository);
  });

  test(
    'should call the [OnBoardingRepository.cacheFirstTimer] '
    'and return the right data',
    () async {
      // Arrange
      when(
        () => repository.cacheFirstTimer(),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Unknown Error Occured',
            statusCode: 500,
          ),
        ),
      );

      // Act
      final result = await usecase();

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error Occured',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
