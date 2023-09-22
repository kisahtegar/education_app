// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/data/datasources/notification_remote_data_src.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';
import 'package:flutter/foundation.dart';

/// A concrete implementation of the [NotificationRepo] interface responsible for
/// handling notifications data retrieval and manipulation from a remote data source.
class NotificationRepoImpl implements NotificationRepo {
  /// Constructs a [NotificationRepoImpl] instance with the provided remote data source.
  ///
  /// [_remoteDataSrc] is the data source responsible for remote communication.
  const NotificationRepoImpl(this._remoteDataSrc);

  final NotificationRemoteDataSrc _remoteDataSrc;

  /// Clears a single notification by its [notificationId].
  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _remoteDataSrc.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Clears all notifications.
  @override
  ResultFuture<void> clearAll() async {
    try {
      await _remoteDataSrc.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Retrieves notifications from the remote data source.
  @override
  ResultStream<List<Notification>> getNotifications() {
    // Transform the notifications stream to handle data and errors.
    return _remoteDataSrc.getNotifications().transform(
          StreamTransformer<List<NotificationModel>,
              Either<Failure, List<Notification>>>.fromHandlers(
            handleData: (notifications, sink) {
              // Successfully received notifications, pass them as a Right result.
              sink.add(Right(notifications));
            },
            handleError: (error, stackTrace, sink) {
              debugPrint(stackTrace.toString());
              if (error is ServerException) {
                // Handle server-related errors and convert them into Left results.
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                // Handle generic errors and convert them into Left results.
                sink.add(
                  Left(
                    ServerFailure(message: error.toString(), statusCode: 505),
                  ),
                );
              }
            },
          ),
        );
  }

  /// Marks a notification as read by its [notificationId].
  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _remoteDataSrc.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  /// Sends a new notification to the remote data source.
  @override
  ResultFuture<void> sendNotification(Notification notification) async {
    try {
      await _remoteDataSrc.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
