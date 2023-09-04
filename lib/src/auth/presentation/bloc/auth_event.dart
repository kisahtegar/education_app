part of 'auth_bloc.dart';

/// These event classes provide a structured way to represent different user
/// actions and events related to authentication in the application. They
/// encapsulate the necessary data for each event and ensure type safety during
/// event creation. These events will likely be used to trigger state changes
/// and perform corresponding authentication logic within the `AuthBloc`.
sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

/// Represents an event for user sign-in.
final class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

/// Represents an event for user sign-up.
final class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  @override
  List<String> get props => [email, password, name];
}

/// Represents an event for password reset.
final class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<String> get props => [email];
}

/// Represents an event for updating user profile information.
final class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.action,
    required this.userData,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be either a String or a File, but '
          'was ${userData.runtimeType}',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
