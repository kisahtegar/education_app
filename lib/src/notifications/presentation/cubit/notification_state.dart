part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

final class GettingNotifications extends NotificationState {
  const GettingNotifications();
}

final class SendingNotification extends NotificationState {
  const SendingNotification();
}

final class ClearingNotifications extends NotificationState {
  const ClearingNotifications();
}

final class NotificationSent extends NotificationState {
  const NotificationSent();
}

final class NotificationCleared extends NotificationState {
  const NotificationCleared();
}

final class NotificationsLoaded extends NotificationState {
  const NotificationsLoaded(this.notifications);

  final List<Notification> notifications;

  @override
  List<Object> get props => notifications;
}

final class NotificationError extends NotificationState {
  const NotificationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
