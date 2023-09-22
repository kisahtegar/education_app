import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';

/// An abstract class defining the contract for handling notifications.
abstract class NotificationRepo {
  /// Constructs a [NotificationRepo].
  const NotificationRepo();

  /// Marks a notification with the given [notificationId] as read.
  ResultFuture<void> markAsRead(String notificationId);

  /// Clears all notifications.
  ResultFuture<void> clearAll();

  /// Clears a notification with the given [notificationId].
  ResultFuture<void> clear(String notificationId);

  /// Sends a new notification.
  ResultFuture<void> sendNotification(Notification notification);

  /// Retrieves a stream of notifications.
  ResultStream<List<Notification>> getNotifications();
}
