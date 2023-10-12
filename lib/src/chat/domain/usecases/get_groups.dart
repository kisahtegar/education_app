import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';

/// Use case for fetching a list of chat groups the current user is a part of.
///
/// This use case retrieves a list of chat groups from the repository. It's
/// asynchronous and returns the result as a stream over time. The stream emits
/// lists of chat groups.
class GetGroups extends StreamUsecaseWithoutParams<List<Group>> {
  /// Creates a [GetGroups] use case with a provided [ChatRepo].
  const GetGroups(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to fetch chat groups.
  ///
  /// Returns a [ResultStream] that provides a stream of lists of [Group].
  /// The stream emits updates to the group list as they are retrieved from
  /// the repository.
  @override
  ResultStream<List<Group>> call() => _repo.getGroups();
}
