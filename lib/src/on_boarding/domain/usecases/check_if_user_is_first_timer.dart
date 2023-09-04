// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

/// The `CheckIfUserIsFirstTimer` use case class facilitates the retrieval of
/// whether a user is a first-time user, providing a convenient way for the app to
/// access this information.
///
/// This use case extends the [UsecaseWithoutParams] class and, when executed,
/// calls the `checkIfUserIsFirstTimer` method from the injected `OnBoardingRepository`.
class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  /// Creates a new instance of the `CheckIfUserIsFirstTimer` use case.
  ///
  /// The `OnBoardingRepository` is provided as a dependency, which will be used
  /// to check the user's first-time status.
  const CheckIfUserIsFirstTimer(this._repository);

  /// The `OnBoardingRepository` used to check whether the user is a first-time user.
  final OnBoardingRepository _repository;

  /// Executes the use case, invoking the `checkIfUserIsFirstTimer` method.
  ///
  /// This method synchronously checks whether the user is a first-time user by
  /// calling the `checkIfUserIsFirstTimer` method from the provided `OnBoardingRepository`.
  ///
  /// Returns a [ResultFuture] with a boolean value representing whether the user
  /// is a first-time user or not.
  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
