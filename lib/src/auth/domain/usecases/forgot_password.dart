import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';

/// The `ForgotPassword` class represents a specific use case that initiates the
/// password reset process for a user. It achieves this by invoking the
/// `forgotPassword` method of an authentication repository (`AuthRepo`). This
/// class adheres to the common use case design pattern, separating the use case
/// logic from the rest of the application and facilitating reusability and
/// testability.
class ForgotPassword extends FutureUsecaseWithParams<void, String> {
  /// Initializes a new instance of the `ForgotPassword` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling password reset requests.
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
