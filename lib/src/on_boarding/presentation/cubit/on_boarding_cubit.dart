// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

/// The `OnBoardingCubit` class manages the state related to onboarding in the application.
/// It handles actions such as caching data for first-time users and checking first-time
/// user status, subsequently updating the UI state accordingly. This separation of concerns
/// improves code organization and facilitates testing.
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  /// Caches first-time user data. It emits a `CachingFirstTimer` state to indicate
  /// the start of the caching process. Subsequently, it invokes the `_cacheFirstTimer()`
  /// method to execute the caching logic. Based on the result, it emits either an
  /// `OnBoardingError` state (in case of failure) or a `UserCached` state (if caching
  /// is successful).
  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  /// Checks if the user is a first-time user. It emits a `CheckingIfUserIsFirstTimer`
  /// state to indicate the start of the verification process. Subsequently, it calls
  /// the `_checkIfUserIsFirstTimer()` method to perform the verification. Depending
  /// on the result, it emits either an `OnBoardingStatus` state (indicating the user's
  /// first-time status) or an `OnBoardingError` state (in case of failure).
  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());

    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
