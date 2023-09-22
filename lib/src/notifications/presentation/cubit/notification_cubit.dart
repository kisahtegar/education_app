import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/usecases/clear.dart';
import 'package:education_app/src/notifications/domain/usecases/clear_all.dart';
import 'package:education_app/src/notifications/domain/usecases/get_notifications.dart';
import 'package:education_app/src/notifications/domain/usecases/mark_as_read.dart';
import 'package:education_app/src/notifications/domain/usecases/send_notification.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

/// A [Cubit] responsible for managing notification-related states and actions.
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required Clear clear,
    required ClearAll clearAll,
    required GetNotifications getNotifications,
    required MarkAsRead markAsRead,
    required SendNotification sendNotification,
  })  : _clear = clear,
        _clearAll = clearAll,
        _getNotifications = getNotifications,
        _markAsRead = markAsRead,
        _sendNotification = sendNotification,
        super(const NotificationInitial());

  final Clear _clear;
  final ClearAll _clearAll;
  final GetNotifications _getNotifications;
  final MarkAsRead _markAsRead;
  final SendNotification _sendNotification;

  /// Clears a notification by its [notificationId].
  Future<void> clear(String notificationId) async {
    emit(const ClearingNotifications());
    final result = await _clear(notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  /// Clears all notifications.
  Future<void> clearAll() async {
    emit(const ClearingNotifications());
    final result = await _clearAll();
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  /// Marks a notification as read by its [notificationId].
  Future<void> markAsRead(String notificationId) async {
    final result = await _markAsRead(notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationInitial()),
    );
  }

  /// Sends a new [notification].
  Future<void> sendNotification(Notification notification) async {
    emit(const SendingNotification());
    final result = await _sendNotification(notification);
    result.fold(
      (failure) => emit(NotificationError(failure.errorMessage)),
      (_) => emit(const NotificationCleared()),
    );
  }

  /// Retrieves and emits notifications from the data source.
  void getNotifications() {
    emit(const GettingNotifications());
    StreamSubscription<Either<Failure, List<Notification>>>? subscription;

    subscription = _getNotifications().listen(
      /*onData:*/
      (result) {
        result.fold(
          (failure) {
            emit(NotificationError(failure.errorMessage));
            subscription?.cancel();
          },
          (notifications) => emit(NotificationsLoaded(notifications)),
        );
      },
      onError: (dynamic error) {
        emit(NotificationError(error.toString()));
        subscription?.cancel();
      },
      onDone: () {
        subscription?.cancel();
      },
    );
  }
}
