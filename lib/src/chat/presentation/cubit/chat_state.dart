part of 'chat_cubit.dart';

/// An abstract class representing the various states that the Chat Cubit can be
/// in. All subclasses of [ChatState] should extend this class and provide their
/// own implementations.
sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the Chat Cubit.
final class ChatInitial extends ChatState {
  const ChatInitial();
}

/// Indicates that the Chat Cubit is currently loading groups.
final class LoadingGroups extends ChatState {
  const LoadingGroups();
}

/// Indicates that the Chat Cubit is currently loading messages.
final class LoadingMessages extends ChatState {
  const LoadingMessages();
}

/// Indicates that the Chat Cubit is currently sending a message.
final class SendingMessage extends ChatState {
  const SendingMessage();
}

/// Indicates that the Chat Cubit is currently joining a group.
final class JoiningGroup extends ChatState {
  const JoiningGroup();
}

/// Indicates that the Chat Cubit is currently leaving a group.
final class LeavingGroup extends ChatState {
  const LeavingGroup();
}

/// Indicates that the Chat Cubit is currently getting user data.
final class GettingUser extends ChatState {
  const GettingUser();
}

/// Indicates that a message has been successfully sent.
final class MessageSent extends ChatState {
  const MessageSent();
}

/// Represents the state where groups have been successfully loaded.
final class GroupsLoaded extends ChatState {
  const GroupsLoaded(this.groups);

  final List<Group> groups;

  @override
  List<Object> get props => [groups];
}

/// Represents the state where a user has been found successfully.
final class UserFound extends ChatState {
  const UserFound(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

/// Represents the state where messages have been successfully loaded.
final class MessagesLoaded extends ChatState {
  const MessagesLoaded(this.messages);

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}

/// Indicates that the Chat Cubit has successfully left a group.
final class LeftGroup extends ChatState {
  const LeftGroup();
}

/// Indicates that the Chat Cubit has successfully joined a group.
final class JoinedGroup extends ChatState {
  const JoinedGroup();
}

/// Represents an error state with an associated error message.
final class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
