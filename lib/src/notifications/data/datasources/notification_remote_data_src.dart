// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Abstract class defining the contract for remote data sources responsible for
/// managing notifications.
abstract class NotificationRemoteDataSrc {
  const NotificationRemoteDataSrc();

  /// Marks a notification as read using its [notificationId].
  Future<void> markAsRead(String notificationId);

  /// Clears all notifications for the authenticated user.
  Future<void> clearAll();

  /// Clears a specific notification using its [notificationId].
  Future<void> clear(String notificationId);

  /// Sends a notification to all users in the system.
  Future<void> sendNotification(Notification notification);

  /// Retrieves a stream of notifications from the remote data source.
  Stream<List<NotificationModel>> getNotifications();
}

/// A concrete implementation of the [NotificationRemoteDataSrc] interface responsible
/// for managing notifications in a remote Firebase Firestore database.
class NotificationRemoteDataSrcImpl implements NotificationRemoteDataSrc {
  const NotificationRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// Clears a specific notification identified by its [notificationId].
  ///
  /// This method first authorizes the user using the provided [_auth] instance.
  /// It then constructs a reference to the targeted notification document within
  /// the user's collection of notifications and deletes it from the Firestore database.
  ///
  /// If any error occurs during the clearing process, the method will handle it
  /// and throw a [ServerException] to indicate the failure. Firebase-related
  /// exceptions are caught and wrapped in a [ServerException] for consistency.
  ///
  /// Parameters:
  /// - [notificationId]: The unique identifier of the notification to be cleared.
  ///
  /// Returns a [Future] representing the completion of the clearing process.
  @override
  Future<void> clear(String notificationId) async {
    try {
      // Ensure user authorization before proceeding.
      await DataSourceUtils.authorizeUser(_auth);

      // Delete the specified notification document.
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions by throwing a [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Rethrow [ServerException] for consistency.
      rethrow;
    } catch (e) {
      // Handle any other exceptions by throwing a [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Clears all notifications for the currently authenticated user.
  ///
  /// This method first authorizes the user using the provided [_auth] instance.
  /// It then constructs a [Query] to access the user's collection of notifications
  /// and calls the private [_deleteNotificationsByQuery] method to delete them.
  ///
  /// If any error occurs during the clearing process, the method will handle it
  /// and throw a [ServerException] to indicate the failure. Firebase-related
  /// exceptions are caught and wrapped in a [ServerException] for consistency.
  ///
  /// Returns a [Future] representing the completion of the clearing process.
  @override
  Future<void> clearAll() async {
    try {
      // Ensure user authorization before proceeding.
      await DataSourceUtils.authorizeUser(_auth);

      // Construct a query to access the user's collection of notifications.
      final query = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications');

      // Delete the notifications using the private method.
      return _deleteNotificationsByQuery(query);
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions by throwing a [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Rethrow [ServerException] for consistency.
      rethrow;
    } catch (e) {
      // Handle any other exceptions by throwing a [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Retrieves a stream of notifications for the currently authenticated user.
  ///
  /// This method returns a [Stream] of [List] of [NotificationModel] objects,
  /// representing the notifications received by the user. Notifications are
  /// ordered by their 'sentAt' timestamp in descending order, meaning the most
  /// recent notifications appear first.
  ///
  /// The method first authorizes the user using the provided [_auth] instance.
  ///
  /// If any error occurs during the retrieval process, the method will handle
  /// it and return an error stream. Firebase-related exceptions are caught
  /// and wrapped in a [ServerException] for consistency.
  ///
  /// Returns a stream of notifications or an error stream if any issue occurs.
  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      // Ensure user authorization before proceeding.
      DataSourceUtils.authorizeUser(_auth);

      // Create a stream of notifications from Firestore.
      final notificationsStream = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs.map((doc) {
              return NotificationModel.fromMap(doc.data());
            }).toList(),
          );

      // Handle any potential errors that may occur during the stream processing.
      return notificationsStream.handleError((
        dynamic error,
        dynamic stackTrace,
      ) {
        if (error is FirebaseException) {
          // Handle Firebase exceptions by throwing a [ServerException].
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        }

        // Print any unexpected errors for debugging purposes.
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());

        // Throw a [ServerException] for any other unhandled errors.
        throw ServerException(message: error.toString(), statusCode: '505');
      });
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and return an error stream.
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } on ServerException catch (e) {
      // Return an error stream if a [ServerException] is thrown.
      return Stream.error(e);
    } catch (e) {
      // Return an error stream for any other unexpected exceptions.
      return Stream.error(
        ServerException(message: e.toString(), statusCode: '505'),
      );
    }
  }

  /// Marks a notification as read using its [notificationId].
  ///
  /// This method updates the 'seen' status of the notification to 'true'
  /// in the Firestore database, indicating that the notification has been read.
  ///
  /// Throws a [ServerException] if any error occurs during the operation.
  ///
  /// [notificationId] is the unique identifier of the notification to mark as read.
  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      // Ensure user authorization before proceeding.
      await DataSourceUtils.authorizeUser(_auth);

      // Update the 'seen' status of the notification to 'true'.
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'seen': true});
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions and wrap them in a [ServerException].
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Rethrow [ServerException] to maintain error consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions and wrap them in a [ServerException].
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Sends a new notification to all users.
  ///
  /// Throws a [ServerException] on failure.
  @override
  Future<void> sendNotification(Notification notification) async {
    try {
      // Ensure the user is authorized before sending notifications.
      await DataSourceUtils.authorizeUser(_auth);

      // add notification to every user's notification collection

      // Retrieve a list of all users in the system.
      final users = await _firestore.collection('users').get();

      if (users.docs.length > 500) {
        // If there are more than 500 users, split the operation into batches
        // to avoid overwhelming Firestore's batch write limitations.

        for (var i = 0; i < users.docs.length; i += 500) {
          // 1400
          final batch = _firestore.batch();

          // Calculate the end index of the current batch.
          final end = i + 500;

          // Extract a subset of users for this batch.
          final usersBatch = users.docs.sublist(
            i,
            // Determine the ending index for the current batch.
            //
            // If end is greater than the total number of users, it means that
            // there are fewer than 500 users remaining, so we use users.docs.length
            // as the ending index.
            end > users.docs.length
                ? users.docs
                    .length // Use the total number of users if fewer than 500 remain.
                : end, // Otherwise, use the calculated ending index for a full batch of 500 users.
          );

          for (final user in usersBatch) {
            // Create a reference for a new notification document within
            // each user's 'notifications' collection.
            final newNotificationRef =
                user.reference.collection('notifications').doc();

            // Set the notification data within the batch.
            batch.set(
              newNotificationRef,
              (notification as NotificationModel)
                  .copyWith(id: newNotificationRef.id)
                  .toMap(),
            );
          }

          // Commit the batch write operation.
          await batch.commit();
        }
      } else {
        // If there are 500 or fewer users, perform a single batch write
        // operation for all users.

        final batch = _firestore.batch();
        for (final user in users.docs) {
          // Create a reference for a new notification document within
          // each user's 'notifications' collection.
          final newNotificationRef =
              user.reference.collection('notifications').doc();

          // Set the notification data within the batch.
          batch.set(
            newNotificationRef,
            (notification as NotificationModel)
                .copyWith(id: newNotificationRef.id)
                .toMap(),
          );
        }

        // Commit the batch write operation.
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions by wrapping them in a ServerException.
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // Rethrow ServerException to maintain error consistency.
      rethrow;
    } catch (e) {
      // Handle other exceptions by wrapping them in a ServerException.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  /// Deletes notifications using the provided Firestore [Query].
  ///
  /// This method is responsible for batch deletion of notifications
  /// based on the specified query.
  Future<void> _deleteNotificationsByQuery(Query query) async {
    // Retrieve the notifications matching the provided query.
    final notifications = await query.get();

    // Check if there are more than 500 notifications to delete.
    if (notifications.docs.length > 500) {
      for (var i = 0; i < notifications.docs.length; i += 500) {
        // Create a batch for efficient batch deletion.
        final batch = _firestore.batch();

        // Calculate the ending index for the current batch.
        final end = i + 500;

        // Extract a subset of notifications for this batch.
        final notificationsBatch = notifications.docs.sublist(
          i,
          // Ensure the ending index does not exceed the total notifications.
          end > notifications.docs.length
              ? notifications
                  .docs.length // Use the total if fewer than 500 remain.
              : end, // Otherwise, use the calculated ending index for a full batch.
        );

        // Delete each notification in the batch.
        for (final notification in notificationsBatch) {
          batch.delete(notification.reference);
        }

        // Commit the batch delete operation.
        await batch.commit();
      }
    } else {
      // If there are 500 or fewer notifications, perform a single batch delete operation.
      final batch = _firestore.batch();

      // Delete each notification in the batch.
      for (final notification in notifications.docs) {
        batch.delete(notification.reference);
      }

      // Commit the batch delete operation.
      await batch.commit();
    }
  }
}
