// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

/// The `CacheFirstTimer` use case is responsible for invoking the
/// `cacheFirstTimer` method provided by the `OnBoardingRepository`. It
/// encapsulates the logic of caching specific data, specifically whether a user
/// is a first-time user. This use case can be employed in the app's onboarding
/// process or any other scenario requiring the caching of this particular
/// information.
///
/// This use case extends the [FutureUsecaseWithoutParams] class and, when executed,
/// calls the `cacheFirstTimer` method from the injected `OnBoardingRepository`.
class CacheFirstTimer extends FutureUsecaseWithoutParams<void> {
  /// Creates a new instance of the `CacheFirstTimer` use case.
  ///
  /// The `OnBoardingRepository` is provided as a dependency, which will be used
  /// for caching data.
  const CacheFirstTimer(this._repository);

  /// The `OnBoardingRepository` used to cache first-time user information.
  final OnBoardingRepository _repository;

  /// Executes the use case, invoking the `cacheFirstTimer` method.
  ///
  /// This method asynchronously caches first-time user information by calling
  /// the `cacheFirstTimer` method from the provided `OnBoardingRepository`.
  ///
  /// Returns a [ResultFuture] representing the success or failure of the caching operation.
  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
