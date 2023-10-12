import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';

/// An abstract class that defines the contract for a repository responsible
/// for managing chat-related data in the application. Implementations of this
/// class handle sending and receiving messages, managing groups, and user-
/// related operations within the chat module.
abstract class ChatRepo {
  const ChatRepo();

  /// Sends a message to a group or user.
  ///
  /// Returns a [ResultFuture] containing the result of the message sending
  /// operation, which may include error information.
  ResultFuture<void> sendMessage(Message message);

  /// Retrieves a list of groups that the current user is part of.
  ///
  /// Returns a [ResultStream] that provides a stream of group lists. The stream
  /// emits updates to the group list over time.
  ResultStream<List<Group>> getGroups();

  /// Retrieves a list of messages for a specified group or user.
  ///
  /// [groupId] is the unique identifier of the group or user for which messages
  /// are to be retrieved.
  ///
  /// Returns a [ResultStream] that provides a stream of message lists for the
  /// specified group or user. The stream emits updates to the message list over
  /// time.
  ResultStream<List<Message>> getMessages(String groupId);

  /// Joins a user to a specified group.
  ///
  /// [groupId] is the unique identifier of the group to join.
  /// [userId] is the unique identifier of the user who is joining the group.
  ///
  /// Returns a [ResultFuture] containing the result of the join operation,
  /// which may include error information.
  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  });

  /// Leaves a user from a specified group.
  ///
  /// [groupId] is the unique identifier of the group to leave.
  /// [userId] is the unique identifier of the user who is leaving the group.
  ///
  /// Returns a [ResultFuture] containing the result of the leave operation,
  /// which may include error information.
  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  });

  /// Retrieves user information by their unique identifier.
  ///
  /// [userId] is the unique identifier of the user to retrieve.
  ///
  /// Returns a [ResultFuture] containing user information associated with the
  /// specified [userId].
  ResultFuture<LocalUser> getUserById(String userId);
}
