import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late MockOnBoardingRepository repository;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CheckIfUserIsFirstTimer(repository);
  });

  test(
    'should get a response from the [MockOnBoardingRepository]',
    () async {
      // Arrange
      when(
        () => repository.checkIfUserIsFirstTimer(),
      ).thenAnswer(
        (_) async => const Right(true),
      );

      // Act
      final result = await usecase();

      // Assert
      expect(
        result,
        equals(const Right<dynamic, bool>(true)),
      );
      verify(() => repository.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
