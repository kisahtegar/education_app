// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/chat/data/datasources/chat_remote_data_source.dart';
import 'package:education_app/src/chat/data/models/group_model.dart';
import 'package:education_app/src/chat/data/models/message_model.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/repos/chat_repo.dart';

/// A concrete implementation of the [ChatRepo] interface. It is responsible for
/// managing chat-related data and communication with remote data sources.
class ChatRepoImpl implements ChatRepo {
  /// Constructs a [ChatRepoImpl] with the provided remote data source.
  const ChatRepoImpl(this._remoteDataSource);

  // The remote data source responsible for handling communication with external
  // services.
  final ChatRemoteDataSource _remoteDataSource;

  /// Retrieves a stream of chat groups from the remote data source.
  ///
  /// This method fetches a continuous stream of chat groups and processes them as
  /// they arrive. It returns a [ResultStream] that represents the asynchronous
  /// result of the operation, including both data and potential failures.
  /// - When chat groups are successfully retrieved, it returns a [Right] with
  ///   the list of [Group] entities.
  /// - If an error occurs during data retrieval, it handles the error:
  ///   - If it's a [ServerException], it returns a [Left] with a [ServerFailure]
  ///     containing error details, including the error message and status code.
  ///   - For other types of exceptions, it constructs a [Left] with a
  ///     [ServerFailure] with a generic error message and a status code of 500.
  @override
  ResultStream<List<Group>> getGroups() {
    return _remoteDataSource.getGroups().transform(
          StreamTransformer<List<GroupModel>,
              Either<Failure, List<Group>>>.fromHandlers(
            // Handles errors that occur while fetching the data.
            handleError: (error, stackTrace, sink) {
              if (error is ServerException) {
                sink.add(
                  Left(
                    ServerFailure(
                      message: error.message,
                      statusCode: error.statusCode,
                    ),
                  ),
                );
              } else {
                // Handle other types of exceptions as needed
                sink.add(
                  Left(
                    ServerFailure(
                      message: error.toString(),
                      statusCode: 500,
                    ),
                  ),
                );
              }
            },
            // Handles the successfully fetched data.
            handleData: (groups, sink) {
              sink.add(Right(groups));
            },
          ),
        );
  }

  /// Sends a chat message using the remote data source.
  ///
  /// This method allows the user to send a chat message to a group using the
  /// remote data source. It returns a [ResultFuture] representing the asynchronous
  /// result of the operation. If the message is successfully sent, it returns a
  /// [Right] with a `null` value.
  /// - In case of an error during message sending, it catches and handles it:
  ///   - If it's a [ServerException], it returns a [Left] with a [ServerFailure]
  ///     containing error details.
  @override
  ResultFuture<void> sendMessage(Message message) async {
    try {
      // Sends a message using the remote data source and returns a success result.
      await _remoteDataSource.sendMessage(message);
      return const Right(null);
    } on ServerException catch (e) {
      // Handles exceptions and returns a failure result with the error details.
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a stream of chat messages for a specific group from the remote data source.
  ///
  /// This method fetches a continuous stream of chat messages for a specific group
  /// and processes them as they arrive. It returns a [ResultStream] representing
  /// the asynchronous result of the operation, including both data and potential
  /// failures.
  /// - When chat messages are successfully retrieved, it returns a [Right] with
  ///   the list of [Message] entities.
  /// - If an error occurs during data retrieval, it handles the error in a similar
  ///   manner as the `getGroups` method.
  @override
  ResultStream<List<Message>> getMessages(String groupId) {
    return _remoteDataSource.getMessages(groupId).transform(_handleStream());
  }

  // A private method to handle stream transformations for message retrieval.
  StreamTransformer<List<MessageModel>, Either<Failure, List<Message>>>
      _handleStream() {
    return StreamTransformer<List<MessageModel>,
        Either<Failure, List<Message>>>.fromHandlers(
      // Handles errors that occur while fetching the messages.
      handleError: (error, stackTrace, sink) {
        if (error is ServerException) {
          sink.add(
            Left(
              ServerFailure(
                message: error.message,
                statusCode: error.statusCode,
              ),
            ),
          );
        } else {
          // Handle other types of exceptions as needed
          sink.add(
            Left(
              ServerFailure(
                message: error.toString(),
                statusCode: 500,
              ),
            ),
          );
        }
      },
      // Handles the successfully fetched messages.
      handleData: (messages, sink) {
        sink.add(Right(messages));
      },
    );
  }

  /// Allows a user to join a specific chat group.
  ///
  /// This method enables a user to join a chat group by providing the group's ID
  /// and the user's ID. It returns a [ResultFuture] representing the asynchronous
  /// result of the operation. If the user successfully joins the group, it returns
  /// a [Right] with `null` value.
  /// - In case of an error during group joining, it catches and handles the error
  ///   similar to the `sendMessage` method.
  @override
  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      // Joins a group using the remote data source and returns a success result.
      await _remoteDataSource.joinGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      // Handles exceptions and returns a failure result with the error details.
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Allows a user to leave a specific chat group.
  ///
  /// This method enables a user to leave a chat group by providing the group's ID
  /// and the user's ID. It returns a [ResultFuture] representing the asynchronous
  /// result of the operation. If the user successfully leaves the group, it returns
  /// a [Right] with `null` value.
  /// - In case of an error during group leaving, it catches and handles the error
  ///   similar to the `sendMessage` method.
  @override
  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      // Leaves a group using the remote data source and returns a success result.
      await _remoteDataSource.leaveGroup(groupId: groupId, userId: userId);
      return const Right(null);
    } on ServerException catch (e) {
      // Handles exceptions and returns a failure result with the error details.
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves a user's data by their ID from the remote data source.
  ///
  /// This method fetches a user's data by specifying the user's ID and returns a
  /// [ResultFuture] representing the asynchronous result of the operation.
  /// - When the user's data is successfully retrieved, it returns a [Right]
  ///   containing the [LocalUser] entity.
  /// - If an error occurs during data retrieval, it handles the error similar to
  ///   the `sendMessage` method.
  @override
  ResultFuture<LocalUser> getUserById(String userId) async {
    try {
      // Fetches a user by their ID from the remote data source.
      final result = await _remoteDataSource.getUserById(userId);
      return Right(result);
    } on ServerException catch (e) {
      // Handles exceptions and returns a failure result with the error details.
      return Left(ServerFailure.fromException(e));
    }
  }
}
