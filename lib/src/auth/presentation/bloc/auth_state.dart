part of 'auth_bloc.dart';

/// These state classes provide a structured way to represent and manage the
/// different states of the authentication process within the `AuthBloc`. Each
/// state encapsulates the necessary data and information about the current
/// state of authentication, making it easier to handle and respond to different
/// scenarios and transitions in the user authentication flow.

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the authentication process.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Represents the state when authentication actions are in progress.
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Represents the state when a user has successfully signed in.
final class SignedIn extends AuthState {
  const SignedIn(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

/// Represents the state when a user has successfully signed up.
final class SignedUp extends AuthState {
  const SignedUp();
}

/// Represents the state when a password reset email is sent successfully.
final class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

/// Represents the state when user profile information is successfully updated.
final class UserUpdated extends AuthState {
  const UserUpdated();
}

/// Represents the state when an error occurs during authentication.
final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
