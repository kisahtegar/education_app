// ignore_for_file: lines_longer_than_80_chars

part of 'on_boarding_cubit.dart';

/// These state classes serve as representations of different UI states within the
/// `OnBoardingCubit`. They facilitate communication of application state changes
/// to the UI during the onboarding process. By utilizing distinct state classes,
/// you can efficiently manage and update the UI in response to various events and
/// data modifications.
sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the onboarding process.
final class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

/// Indicates that the application is currently caching data for first-time users.
final class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

/// Signifies that the application is in the process of checking whether the user
/// is a first-time user.
final class CheckingIfUserIsFirstTimer extends OnBoardingState {
  const CheckingIfUserIsFirstTimer();
}

/// Indicates that the user's data has been successfully cached.
final class UserCached extends OnBoardingState {
  const UserCached();
}

/// Represents the onboarding status, including whether the user is a first-time user.
final class OnBoardingStatus extends OnBoardingState {
  const OnBoardingStatus({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

/// Indicates an error state during the onboarding process and provides an error message.
final class OnBoardingError extends OnBoardingState {
  const OnBoardingError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
