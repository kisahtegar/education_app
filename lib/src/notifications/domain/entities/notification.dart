import 'package:education_app/core/enums/notification_enum.dart';
import 'package:equatable/equatable.dart';

/// A class representing a notification with various properties.
class Notification extends Equatable {
  /// Constructs a [Notification] with required properties.
  ///
  /// - [id] uniquely identifies the notification.
  /// - [title] is the title of the notification.
  /// - [body] is the content or message of the notification.
  /// - [category] specifies the category of the notification (e.g., alert,
  ///   message).
  /// - [sentAt] is the timestamp when the notification was sent.
  /// - [seen] indicates whether the notification has been viewed by the user
  ///   (default is false).
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.sentAt,
    this.seen = false,
  });

  /// Constructs an empty [Notification] for fallback or default purposes.
  ///
  /// This is typically used when no real notifications are available.
  Notification.empty()
      : id = '_empty.id',
        title = '_empty.title',
        body = '_empty.body',
        category = NotificationCategory.NONE,
        seen = false,
        sentAt = DateTime.now();

  /// A unique identifier for the notification.
  final String id;

  /// The title or subject of the notification.
  final String title;

  /// The main content or message of the notification.
  final String body;

  /// The category or type of the notification (e.g., alert, message).
  final NotificationCategory category;

  /// Indicates whether the notification has been seen by the user.
  final bool seen;

  /// The timestamp when the notification was sent.
  final DateTime sentAt;

  @override
  List<Object?> get props => [id];
}
