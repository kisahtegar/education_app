import 'package:education_app/core/enums/notification_enum.dart';

/// Extension to convert a string to a [NotificationCategory].
extension NotificationExt on String {
  /// Converts a string to a [NotificationCategory].
  ///
  /// Return the corresponding [NotificationCategory] based on the string value.
  /// If no matching category is found, it returns [NotificationCategory.NONE].
  NotificationCategory get toNotificationCategory {
    switch (this) {
      case 'test':
        return NotificationCategory.TEST;
      case 'video':
        return NotificationCategory.VIDEO;
      case 'material':
        return NotificationCategory.MATERIAL;
      case 'course':
        return NotificationCategory.COURSE;
      default:
        return NotificationCategory.NONE;
    }
  }
}
