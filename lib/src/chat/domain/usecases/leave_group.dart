import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';
import 'package:equatable/equatable.dart';

/// Use case for allowing a user to leave a group.
///
/// This use case enables a user to leave a group by providing the group ID and
/// the user's ID. It's asynchronous and returns the result as a future.
class LeaveGroup extends FutureUsecaseWithParams<void, LeaveGroupParams> {
  const LeaveGroup(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to allow a user to leave a group.
  ///
  /// [params] is an instance of [LeaveGroupParams] containing the group ID and
  /// the user ID.
  ///
  /// Returns a [ResultFuture] that signifies the success or failure of the
  /// leave operation.
  @override
  ResultFuture<void> call(LeaveGroupParams params) => _repo.leaveGroup(
        groupId: params.groupId,
        userId: params.userId,
      );
}

/// Parameters required for allowing a user to leave a group.
///
/// It contains the unique identifier of the group and the user to be removed.
class LeaveGroupParams extends Equatable {
  const LeaveGroupParams({required this.groupId, required this.userId});

  const LeaveGroupParams.empty()
      : groupId = '',
        userId = '';

  final String groupId;
  final String userId;

  @override
  List<String> get props => [groupId, userId];
}
