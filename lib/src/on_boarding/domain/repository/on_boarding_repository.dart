// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';

/// `OnBoardingRepository` is an abstract class that defines a contract for
/// accessing and manipulating onboarding-related data within the application. It
/// enforces consistency and provides a clear interface for concrete repository
/// implementations to follow. The specific behavior of the methods, error
/// handling, and data sources will be determined by the concrete implementation
/// of this repository.
///
/// The primary purpose of this repository is to manage onboarding-related data,
/// including whether a user is a first-time user or not.
abstract class OnBoardingRepository {
  /// Creates a new `OnBoardingRepository` instance.
  const OnBoardingRepository();

  /// Caches information indicating whether a user is a first-time user.
  ///
  /// This method is responsible for storing data that indicates whether a user
  /// is a first-time user. The exact implementation and storage mechanism are
  /// determined by concrete implementations of this repository.
  ///
  /// Returns a [ResultFuture] representing the success or failure of the operation.
  ResultFuture<void> cacheFirstTimer();

  /// Checks if the user is a first-time user.
  ///
  /// This method is responsible for retrieving data that indicates whether a user
  /// is a first-time user. The exact implementation and data source are determined
  /// by concrete implementations of this repository.
  ///
  /// Returns a [ResultFuture] containing a boolean value indicating whether the
  /// user is a first-time user. If the operation is successful, the value will be
  /// `true` if the user is a first-time user, or `false` if not. If the operation
  /// fails, an error will be provided.
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
