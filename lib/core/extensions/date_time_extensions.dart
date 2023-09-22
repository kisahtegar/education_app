// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/extensions/int_extensions.dart';

/// Extension on the [DateTime] class to provide a human-readable time ago format.
extension DateTimeExt on DateTime {
  /// Converts a [DateTime] object to a human-readable time ago format.
  ///
  /// It calculates the time difference between the current time and the given
  /// [DateTime], and returns a string representing how long ago the provided
  /// date was. The format varies from seconds, minutes, hours, days, months, to
  /// years.
  ///
  /// Example output:
  /// - "3 years ago"
  /// - "2 months ago"
  /// - "5 days ago"
  /// - "1 hour ago"
  /// - "30 minutes ago"
  /// - "now" (for current time)
  String get timeAgo {
    final nowUtc = DateTime.now().toUtc();

    final difference = nowUtc.difference(toUtc());

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years.pluralize} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months.pluralize} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays.pluralize} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours.pluralize} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} '
          'minute${difference.inMinutes.pluralize} ago';
    } else {
      return 'now';
    }
  }
}
