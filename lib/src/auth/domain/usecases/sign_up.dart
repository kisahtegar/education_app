import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

/// The `SignUp` class represents a use case for user registration. It depends
/// on an `AuthRepo` instance to perform the actual registration operation.
class SignUp extends FutureUsecaseWithParams<void, SignUpParams> {
  /// Initializes a new instance of the `SignUp` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling user registration requests.
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}

/// The `SignUpParams` class defines the required parameters for user
/// registration, including email, password, and full name. It can be used to
/// create an instance of these parameters for invoking the sign-up use case.
class SignUpParams extends Equatable {
  /// Initializes a new instance of `SignUpParams` with the provided email,
  /// password, and full name.
  ///
  /// - [email] - The user's email for registration.
  /// - [password] - The user's password for registration.
  /// - [fullName] - The user's full name for registration.
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  /// Creates an instance of `SignUpParams` with default or empty values for
  /// email, password, and full name. This is useful for initializing an empty
  /// sign-up parameters object when needed.
  const SignUpParams.empty() : this(email: '', password: '', fullName: '');

  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password, fullName];
}
