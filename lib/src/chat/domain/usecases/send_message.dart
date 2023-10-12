import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';

/// Use case for sending a message in a chat.
///
/// This use case allows a user to send a message in a chat. It takes a
/// [Message] object as a parameter and returns a [ResultFuture] indicating the
/// success or failure of the message sending operation.
class SendMessage extends FutureUsecaseWithParams<void, Message> {
  const SendMessage(this._repo);

  final ChatRepo _repo;

  /// Executes the use case to send a message in a chat.
  ///
  /// [params] is a [Message] object containing the message content, sender ID,
  /// group ID, and timestamp.
  ///
  /// Returns a [ResultFuture] that signifies the success or failure of the
  /// message sending operation.
  @override
  ResultFuture<void> call(Message params) async => _repo.sendMessage(params);
}
