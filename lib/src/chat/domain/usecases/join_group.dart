import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';
import 'package:equatable/equatable.dart';

/// Use case for allowing a user to join a group.
///
/// This use case enables a user to join a group by providing the group ID and
/// the user's ID. It's asynchronous and returns the result as a future.
class JoinGroup extends FutureUsecaseWithParams<void, JoinGroupParams> {
  const JoinGroup(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to allow a user to join a group.
  ///
  /// [params] is an instance of [JoinGroupParams] containing the group ID and
  /// the user ID.
  ///
  /// Returns a [ResultFuture] that signifies the success or failure of the
  /// join operation.
  @override
  ResultFuture<void> call(JoinGroupParams params) => _repo.joinGroup(
        groupId: params.groupId,
        userId: params.userId,
      );
}

/// Parameters required for allowing a user to join a group.
///
/// It contains the unique identifier of the group and the user to be joined.
class JoinGroupParams extends Equatable {
  const JoinGroupParams({required this.groupId, required this.userId});

  const JoinGroupParams.empty()
      : groupId = '',
        userId = '';

  final String groupId;
  final String userId;

  @override
  List<String> get props => [groupId, userId];
}
