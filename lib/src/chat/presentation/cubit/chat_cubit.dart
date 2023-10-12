import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/usecases/get_groups.dart';
import 'package:education_app/src/chat/domain/usecases/get_messages.dart';
import 'package:education_app/src/chat/domain/usecases/get_user_by_id.dart';
import 'package:education_app/src/chat/domain/usecases/join_group.dart';
import 'package:education_app/src/chat/domain/usecases/leave_group.dart';
import 'package:education_app/src/chat/domain/usecases/send_message.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';

/// A BLoC (Business Logic Component) responsible for managing chat-related
/// states and actions.
class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required GetGroups getGroups,
    required GetMessages getMessages,
    required GetUserById getUserById,
    required JoinGroup joinGroup,
    required LeaveGroup leaveGroup,
    required SendMessage sendMessage,
  })  : _getGroups = getGroups,
        _getMessages = getMessages,
        _getUserById = getUserById,
        _joinGroup = joinGroup,
        _leaveGroup = leaveGroup,
        _sendMessage = sendMessage,
        super(const ChatInitial());

  final GetGroups _getGroups;
  final GetMessages _getMessages;
  final GetUserById _getUserById;
  final JoinGroup _joinGroup;
  final LeaveGroup _leaveGroup;
  final SendMessage _sendMessage;

  /// Sends a chat message to a group.
  ///
  /// This method triggers the sending process for a [Message] and updates the
  /// state accordingly. It emits [SendingMessage] state when the message
  /// sending starts and [MessageSent] state if the message is successfully
  /// sent. In case of an error, it emits [ChatError] with an error message.
  Future<void> sendMessage(Message message) async {
    emit(const SendingMessage());
    final result = await _sendMessage(message);
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const MessageSent()),
    );
  }

  /// Allows a user to join a specific chat group.
  ///
  /// This method triggers the group joining process and updates the state
  /// accordingly. It emits [JoiningGroup] state when joining begins and
  /// [JoinedGroup] state when the user successfully joins the group. In case
  /// of an error, it emits [ChatError] with an error message.
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const JoiningGroup());
    final result = await _joinGroup(
      JoinGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const JoinedGroup()),
    );
  }

  /// Allows a user to leave a specific chat group.
  ///
  /// This method triggers the group leaving process and updates the state
  /// accordingly. It emits [LeavingGroup] state when leaving begins and
  /// [LeftGroup] state when the user successfully leaves the group. In case
  /// of an error, it emits [ChatError] with an error message.
  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    emit(const LeavingGroup());
    final result = await _leaveGroup(
      LeaveGroupParams(groupId: groupId, userId: userId),
    );
    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (_) => emit(const LeftGroup()),
    );
  }

  /// Fetches user data by their ID.
  ///
  /// This method initiates the process of fetching user data by their ID and
  /// updates the state accordingly. It emits [GettingUser] state during the
  /// fetch, and if the user data is successfully retrieved, it emits
  /// [UserFound] with the user data. In case of an error, it emits [ChatError]
  /// with an error message.
  Future<void> getUser(String userId) async {
    emit(const GettingUser());
    final result = await _getUserById(userId);

    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (user) => emit(UserFound(user)),
    );
  }

  /// Fetches a list of chat groups.
  ///
  /// This method initiates the process of fetching a list of chat groups and
  /// updates the state accordingly. It emits [LoadingGroups] state during the
  /// fetch, and if the groups are successfully retrieved, it emits
  /// [GroupsLoaded] with the groups. In case of an error, it emits [ChatError]
  /// with an error message.
  void getGroups() {
    emit(const LoadingGroups());

    StreamSubscription<Either<Failure, List<Group>>>? subscription;

    subscription = _getGroups().listen(
      (result) {
        result.fold(
          (failure) => emit(ChatError(failure.errorMessage)),
          (groups) => emit(GroupsLoaded(groups)),
        );
      },
      onError: (dynamic error) {
        emit(ChatError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }

  /// Fetches a list of chat messages for a specific group.
  ///
  /// This method initiates the process of fetching messages for a specified
  /// group and updates the state accordingly. It emits [LoadingMessages] state
  /// during the fetch, and if the messages are successfully retrieved, it emits
  /// [MessagesLoaded] with the messages. In case of an error, it emits
  /// [ChatError] with an error message.
  void getMessages(String groupId) {
    emit(const LoadingMessages());

    StreamSubscription<Either<Failure, List<Message>>>? subscription;

    subscription = _getMessages(groupId).listen(
      (result) {
        result.fold(
          (failure) => emit(ChatError(failure.errorMessage)),
          (messages) => emit(MessagesLoaded(messages)),
        );
      },
      onError: (dynamic error) {
        emit(ChatError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }
}
