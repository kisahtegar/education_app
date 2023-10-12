// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/chat/data/models/group_model.dart';
import 'package:education_app/src/chat/data/models/message_model.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatRemoteDataSource {
  const ChatRemoteDataSource();

  /// Sends a chat message to a group.
  ///
  /// This method takes a [Message] object and sends it to the specified chat
  /// group. It doesn't return any value but may throw a [ServerException] if an
  /// error occurs.
  Future<void> sendMessage(Message message);

  /// Retrieves a stream of chat messages for a specific group.
  ///
  /// This method returns a continuous stream of chat messages for the specified
  /// group in real-time. It listens for new messages and handles errors by
  /// throwing a [ServerException] in case of failure.
  Stream<List<MessageModel>> getMessages(String groupId);

  /// Retrieves a stream of chat groups.
  ///
  /// This method returns a continuous stream of chat groups, which is useful
  /// for listing available chat groups. It listens for changes and throws a
  /// [ServerException] if there is an issue.
  Stream<List<GroupModel>> getGroups();

  /// Allows a user to join a specific chat group.
  ///
  /// This method lets a user join a chat group by providing the group's ID and
  /// the user's ID. It doesn't return any value but may throw a [ServerException]
  /// in case of an error.
  Future<void> joinGroup({required String groupId, required String userId});

  /// Allows a user to leave a specific chat group.
  ///
  /// This method allows a user to leave a chat group by providing the group's
  /// ID and the user's ID. It doesn't return any value but may throw a
  /// [ServerException] if there's an error.
  Future<void> leaveGroup({required String groupId, required String userId});

  /// Retrieves user data by their ID.
  ///
  /// This method fetches a user's data by their ID from the remote data source.
  /// It returns a [LocalUserModel] object representing the user. In case of an
  /// error, it throws a [ServerException].
  Future<LocalUserModel> getUserById(String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Stream<List<GroupModel>> getGroups() {
    try {
      // Authorize the user with Firebase Authentication.
      DataSourceUtils.authorizeUser(_auth);

      // Fetch a stream of chat groups from Firestore and map them to [GroupModel] objects.
      final groupsStream =
          _firestore.collection('groups').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => GroupModel.fromMap(doc.data()))
            .toList();
      });

      return groupsStream.handleError((dynamic error) {
        // Handle any errors during data retrieval, including Firebase errors.
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        } else {
          throw ServerException(
            message: error.toString(),
            statusCode: '500',
          );
        }
      });
    } on FirebaseException catch (e) {
      // Handle Firebase-related errors and throw a [ServerException].
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      // Handle other unexpected errors and throw a [ServerException].
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String groupId) {
    try {
      // Authorize the user with Firebase Authentication.
      DataSourceUtils.authorizeUser(_auth);

      // Fetch a continuous stream of chat messages for the specified group.
      final messagesStream = _firestore
          .collection('groups')
          .doc(groupId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
      });

      return messagesStream.handleError((dynamic error) {
        if (error is FirebaseException) {
          // Handle Firebase-related errors and throw a [ServerException].
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        } else {
          // Handle other types of exceptions and throw a [ServerException] with
          // a generic error message.
          throw ServerException(
            message: error.toString(),
            statusCode: '500',
          );
        }
      });
    } on FirebaseException catch (e) {
      // Handle Firebase-related errors and throw a [ServerException].
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } catch (e) {
      // Handle other unexpected errors and throw a [ServerException].
      return Stream.error(
        ServerException(
          message: e.toString(),
          statusCode: '500',
        ),
      );
    }
  }

  @override
  Future<LocalUserModel> getUserById(String userId) async {
    try {
      // Authorize the user with Firebase Authentication.
      await DataSourceUtils.authorizeUser(_auth);

      // Fetch user data from Firestore by their ID.
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        // Handle the case where the user is not found and throw a [ServerException].
        throw const ServerException(
          message: 'User not found',
          statusCode: '404',
        );
      }
      return LocalUserModel.fromMap(userDoc.data()!);
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      // Authorize the user with Firebase Authentication.
      await DataSourceUtils.authorizeUser(_auth);

      // Update the specified group and user documents to reflect the user joining the group.
      await _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayUnion([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'groups': FieldValue.arrayUnion([groupId]),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      // Authorize the user with Firebase Authentication.
      await DataSourceUtils.authorizeUser(_auth);

      // Update the specified group and user documents to reflect the user leaving the group.
      await _firestore.collection('groups').doc(groupId).update({
        'members': FieldValue.arrayRemove([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'groups': FieldValue.arrayRemove([groupId]),
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> sendMessage(Message message) async {
    try {
      // Authorize the user with Firebase Authentication.
      await DataSourceUtils.authorizeUser(_auth);

      // Create a reference to the message document in the specified group's collection.
      final messageRef = _firestore
          .collection('groups')
          .doc(message.groupId)
          .collection('messages')
          .doc();

      // Prepare the message to upload, ensuring it has a unique identifier.
      final messageToUpload =
          (message as MessageModel).copyWith(id: messageRef.id);

      // Set the message document with its content and metadata.
      await messageRef.set(messageToUpload.toMap());

      // Update the last message details in the group document.
      await _firestore.collection('groups').doc(message.groupId).update({
        'lastMessage': message.message,
        'lastMessageSenderName': _auth.currentUser!.displayName,
        'lastMessageTimestamp': message.timestamp,
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and convert them to [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Re-throw [ServerException] to maintain consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and convert them to [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
