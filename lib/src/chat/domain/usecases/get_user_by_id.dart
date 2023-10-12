import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';

/// Use case for fetching a user by their unique identifier.
///
/// This use case retrieves a user from the repository based on the provided
/// user ID. It's asynchronous and returns the result as a future.
class GetUserById extends FutureUsecaseWithParams<LocalUser, String> {
  /// Creates a [GetUserById] use case with a provided [ChatRepo].
  const GetUserById(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to fetch a user by their unique identifier.
  ///
  /// [params] is the unique identifier (user ID) of the user to be retrieved.
  ///
  /// Return a [ResultFuture] that provide the user information as a [LocalUser]
  /// if found, or an error if the user is not found in the repository.
  @override
  ResultFuture<LocalUser> call(String params) => _repo.getUserById(params);
}
