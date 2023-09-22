part of 'notification_cubit.dart';

/// Base class for the states of the Notification Cubit.
sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

/// Represents the initial state of the Notification Cubit.
final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

/// Represents the state when getting notifications is in progress.
final class GettingNotifications extends NotificationState {
  const GettingNotifications();
}

/// Represents the state when sending a notification is in progress.
final class SendingNotification extends NotificationState {
  const SendingNotification();
}

/// Represents the state when clearing notifications is in progress.
final class ClearingNotifications extends NotificationState {
  const ClearingNotifications();
}

/// Represents the state when a notification has been successfully sent.
final class NotificationSent extends NotificationState {
  const NotificationSent();
}

/// Represents the state when notifications have been successfully cleared.
final class NotificationCleared extends NotificationState {
  const NotificationCleared();
}

/// Represents the state when notifications have been loaded successfully.
final class NotificationsLoaded extends NotificationState {
  const NotificationsLoaded(this.notifications);

  /// The list of notifications that have been loaded.
  final List<Notification> notifications;

  @override
  List<Object> get props => notifications;
}

/// Represents the state when an error occurs while handling notifications.
final class NotificationError extends NotificationState {
  const NotificationError(this.message);

  /// The error message associated with the notification error.
  final String message;

  @override
  List<Object> get props => [message];
}
