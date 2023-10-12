import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';

/// Use case for fetching a list of messages in a specific chat group.
///
/// This use case retrieves a list of messages from the repository based on the
/// provided group ID. It's asynchronous and returns the result as a stream over
/// time. The stream emits lists of messages.
class GetMessages extends StreamUsecaseWithParams<List<Message>, String> {
  /// Creates a [GetMessages] use case with a provided [ChatRepo].
  const GetMessages(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to fetch messages in a chat group.
  ///
  /// [params] is the unique identifier of the chat group for which messages are
  /// to be retrieved.
  ///
  /// Returns a [ResultStream] that provides a stream of lists of [Message].
  /// The stream emits updates to the message list as they are retrieved from
  /// the repository.
  @override
  ResultStream<List<Message>> call(String params) => _repo.getMessages(params);
}
