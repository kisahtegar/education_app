// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class NotificationRemoteDataSrc {
  const NotificationRemoteDataSrc();

  Future<void> markAsRead(String notificationId);

  Future<void> clearAll();

  Future<void> clear(String notificationId);

  Future<void> sendNotification(Notification notification);

  Stream<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSrcImpl implements NotificationRemoteDataSrc {
  const NotificationRemoteDataSrcImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> clear(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await DataSourceUtils.authorizeUser(_auth);

      final query = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications');
      return _deleteNotificationsByQuery(query);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      DataSourceUtils.authorizeUser(_auth);
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
      return notificationsStream.handleError((
        dynamic error,
        dynamic stackTrace,
      ) {
        if (error is FirebaseException) {
          throw ServerException(
            message: error.message ?? 'Unknown error occurred',
            statusCode: error.code,
          );
        }
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        throw ServerException(message: error.toString(), statusCode: '505');
      });
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          message: e.message ?? 'Unknown error occurred',
          statusCode: e.code,
        ),
      );
    } on ServerException catch (e) {
      return Stream.error(e);
    } catch (e) {
      return Stream.error(
        ServerException(message: e.toString(), statusCode: '505'),
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await DataSourceUtils.authorizeUser(_auth);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .doc(notificationId)
          .update({'seen': true});
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

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

  Future<void> _deleteNotificationsByQuery(Query query) async {
    final notifications = await query.get();
    if (notifications.docs.length > 500) {
      for (var i = 0; i < notifications.docs.length; i += 500) {
        final batch = _firestore.batch();
        final end = i + 500;
        final notificationsBatch = notifications.docs.sublist(
          i,
          end > notifications.docs.length ? notifications.docs.length : end,
        );
        for (final notification in notificationsBatch) {
          batch.delete(notification.reference);
        }
        await batch.commit();
      }
    } else {
      final batch = _firestore.batch();
      for (final notification in notifications.docs) {
        batch.delete(notification.reference);
      }
      await batch.commit();
    }
  }
}
