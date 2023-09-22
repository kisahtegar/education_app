// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repos/notification_repo.dart';

/// A use case that sends a notification.
class SendNotification extends FutureUsecaseWithParams<void, Notification> {
  /// Constructs a [SendNotification] use case with the provided [_repo].
  ///
  /// [_repo] is the notification repository responsible for sending notifications.
  const SendNotification(this._repo);

  final NotificationRepo _repo;

  /// Executes the use case to send a notification.
  ///
  /// [params] is the notification to be sent.
  ///
  /// Returns a [ResultFuture] indicating the success or failure of the operation.
  @override
  ResultFuture<void> call(Notification params) =>
      _repo.sendNotification(params);
}
