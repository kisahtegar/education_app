import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/notification_enum.dart';
import 'package:education_app/core/extensions/enum_extensions.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';

/// A model class representing a notification in the application.
class NotificationModel extends Notification {
  /// Constructs a [NotificationModel] instance with the provided attributes.
  ///
  /// - [id] is the unique identifier of the notification.
  /// - [title] is the title of the notification.
  /// - [body] is the content or message of the notification.
  /// - [category] is the category or type of the notification.
  /// - [seen] indicates whether the notification has been seen or not.
  /// - [sentAt] is the timestamp when the notification was sent.
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.category,
    required super.sentAt,
    super.seen,
  });

  /// Constructs a [NotificationModel] instance from a map of data.
  ///
  /// [map] is the data map containing notification information.
  NotificationModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          body: map['body'] as String,
          category: (map['category'] as String).toNotificationCategory,
          seen: map['seen'] as bool,
          sentAt: (map['sentAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );

  /// Constructs an empty [NotificationModel] instance with default values.
  NotificationModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          body: '_empty.body',
          category: NotificationCategory.NONE,
          seen: false,
          sentAt: DateTime.now(),
        );

  /// Creates a copy of the current [NotificationModel] with optional attribute
  /// changes.
  ///
  /// This method is useful for updating specific attributes of a notification.
  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationCategory? category,
    bool? seen,
    DateTime? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      seen: seen ?? this.seen,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  /// Converts the [NotificationModel] to a map of data for serialization.
  DataMap toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'category': category.value,
        'seen': seen,
        'sentAt': FieldValue.serverTimestamp(),
      };
}
