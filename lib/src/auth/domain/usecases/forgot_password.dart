import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';

/// `ForgotPassword` class is a specific use case that initiates the password
/// reset process for a user by invoking the `forgotPassword` method of an
/// authentication repository (`AuthRepo`). It follows a common use case design
/// pattern, separating the use case logic from the rest of the application and
/// making it reusable and testable.
class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
