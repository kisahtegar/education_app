// ignore_for_file: constant_identifier_names

import 'package:education_app/core/res/media_res.dart';

/// An enumeration representing different notification categories.
enum NotificationCategory {
  /// Test category.
  TEST(value: 'test', image: MediaRes.test),

  /// Video category.
  VIDEO(value: 'video', image: MediaRes.video),

  /// Material category.
  MATERIAL(value: 'material', image: MediaRes.material),

  /// Course category.
  COURSE(value: 'course', image: MediaRes.course),

  /// Default category (none).
  NONE(value: 'none', image: MediaRes.course);

  /// Creates an instance of [NotificationCategory].
  ///
  /// - The `value` parameter represents the category's unique identifier.
  /// - The `image` parameter represents the associated image resource.
  const NotificationCategory({required this.value, required this.image});

  /// The value associated with the notification category.
  final String value;

  /// The image resource associated with the notification category.
  final String image;
}
