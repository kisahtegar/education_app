import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

/// The `OnBoardingCubit` class is a crucial part of managing the state related
/// to onboarding in the application. It handles actions like caching data for
/// first-time users and checking the first-time user status, updating the UI
/// `state` accordingly. This separation of concerns makes it easier to manage
/// and test the application's logic.
class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  /// This method is used to cache the first-time user data. It emits a state of
  /// `CachingFirstTimer` to indicate that the caching process has started. Then
  /// it calls the `_cacheFirstTimer()` method to execute the caching logic.
  /// Depending on the result, it emits either an `OnBoardingError` state (if
  /// there's a failure) or a `UserCached` state (if the caching is successful).
  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());

    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  /// This method is used to check if the user is a first-time user. It emits a
  /// state of `CheckingIfUserIsFirstTimer` to indicate that the checking proces
  /// has started. Then, it calls the `_checkIfUserIsFirstTimer()` method to
  /// execute the checking logic. Depending on the result, it emits either an
  /// `OnBoardingStatus` state (indicating whether the user is a first-time
  /// user) or an `OnBoardingError` state (if there's a failure).
  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());

    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
