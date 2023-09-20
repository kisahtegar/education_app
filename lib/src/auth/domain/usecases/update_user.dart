import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

/// The `UpdateUser` class represents a use case for updating user profile
/// information. It depends on an `AuthRepo` instance to perform the actual
/// profile update operation.
class UpdateUser extends FutureUsecaseWithParams<void, UpdateUserParams> {
  /// Initializes a new instance of the `UpdateUser` use case.
  ///
  /// [_repo] - The authentication repository (`AuthRepo`) responsible for
  /// handling user profile update requests.
  const UpdateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

/// The `UpdateUserParams` class defines the required parameters for profile
/// updates, including the action type and associated user data. It can be used
/// to create instances of these parameters for invoking the update user profile
/// use case.
class UpdateUserParams extends Equatable {
  /// Initializes a new instance of `UpdateUserParams` with the provided action
  /// type and user data.
  ///
  /// - [action] - The type of profile update action to perform.
  /// - [userData] - The user data associated with the action.
  const UpdateUserParams({required this.action, required this.userData});

  /// Creates an instance of `UpdateUserParams` with default or empty values for
  /// the action type and user data. This is useful for initializing an empty
  /// update user profile parameters object when needed.
  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
