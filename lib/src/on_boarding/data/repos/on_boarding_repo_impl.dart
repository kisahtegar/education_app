// ignore_for_file: lines_longer_than_80_chars

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

/// `OnBoardingRepoImpl` is an implementation of the `OnBoardingRepository`
/// interface that provides concrete functionality for caching and retrieving
/// onboarding-related data. It uses error handling to manage exceptions and
/// returns results wrapped in `Either` to indicate success or failure in a
/// functional and predictable manner.
class OnBoardingRepoImpl implements OnBoardingRepository {
  /// Constructs an instance of [OnBoardingRepoImpl] with the provided
  /// `OnBoardingLocalDataSource` instance [_localDataSource].
  const OnBoardingRepoImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  /// Caches the information indicating whether a user is a first-time user.
  ///
  /// Delegates this functionality to the [_localDataSource] instance. If the
  /// caching is successful, it returns `Right(null)` using the Either type
  /// from the `dartz` package. If any errors occur during the caching process,
  /// it catches the `CacheException` thrown by [_localDataSource] and returns
  /// a `Left` value containing a `CacheFailure` with an error message and status code.
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  /// Checks whether a user is a first-time user.
  ///
  /// Retrieves the value from the [_localDataSource] instance. If the retrieval
  /// is successful, it returns `Right(result)` with the retrieved value as a bool.
  /// If any errors occur during the retrieval process, it catches the `CacheException`
  /// thrown by [_localDataSource] and returns a `Left` value containing a `CacheFailure`
  /// with an error message and status code.
  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
