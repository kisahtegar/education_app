import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

/// The `SignIn` class represents a use case for user sign-in. It depends on an
/// `AuthRepo` instance to perform the actual sign-in operation.
class SignIn extends FutureUsecaseWithParams<LocalUser, SignInParams> {
  /// Initializes a new instance of the `SignIn` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling user sign-in requests.
  const SignIn(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

/// The `SignInParams` class defines the required parameters for user sign-in,
/// including email and password. It can be used to create instances of these
/// parameters for invoking the sign-in use case.
class SignInParams extends Equatable {
  /// Initializes a new instance of `SignInParams` with the provided email and
  /// password.
  ///
  /// - [email] - The user's email for authentication.
  /// - [password] - The user's password for authentication.
  const SignInParams({
    required this.email,
    required this.password,
  });

  /// Creates an instance of `SignInParams` with default or empty values for
  /// email and password. This is useful for initializing an empty sign-in
  /// parameters object when needed.
  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
