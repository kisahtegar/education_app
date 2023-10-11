/// The `IntExt` extension enhances integer functionality, including estimating
/// values and handling time durations.
extension IntExt on int {
  /// Estimates the value, providing a human-friendly representation.
  ///
  /// If the integer is 10 or less, it returns the integer itself as a string.
  /// For integers greater than 10, it rounds to the nearest multiple of 10 and
  /// returns a string like "over 10" or "over 20" based on the rounded value.
  ///
  /// Example:
  /// ```dart
  /// final count1 = 5;
  /// final count2 = 15;
  ///
  /// print(count1.estimate); // Output: '5'
  /// print(count2.estimate); // Output: 'over 10'
  /// ```
  String get estimate {
    // If the integer is 10 or less, return it as a string.
    if (this <= 10) return '$this';

    var data = this - (this % 10);

    // If the integer is not divisible by 10, round it down to the nearest
    // multiple of 10.
    if (data == this) data = this - 5;

    // Return a string like "over 10" or "over 20" based on the rounded value.
    return 'over $data';
  }

  /// Returns 's' for pluralization if the integer is greater than 1 or zero,
  /// and an empty string for singular.
  String get pluralize {
    return (this > 1 || this == 0) ? 's' : '';
  }

  /// Converts the integer into a human-readable duration format.
  ///
  /// - If the integer represents seconds, it returns '${this}s'.
  /// - If the integer represents minutes, it returns '${this}m'.
  /// - If the integer represents hours, it returns '${this}h'.
  /// - If the integer represents days, it returns '${this}d'.
  ///
  /// Example:
  /// ```dart
  /// final seconds = 45;
  /// final minutes = 150;
  /// final hours = 7200;
  /// final days = 129600;
  ///
  /// print(seconds.displayDuration); // Output: '45s'
  /// print(minutes.displayDuration); // Output: '2m'
  /// print(hours.displayDuration);   // Output: '2h'
  /// print(days.displayDuration);    // Output: '2d'
  /// ```
  String get displayDuration {
    if (this <= 60) return '${this}s';
    if (this <= 3600) return '${(this / 60).round()}m';
    if (this <= 86400) return '${(this / 3600).round()}h';
    return '${(this / 86400).round()}d';
  }

  /// Converts the integer into a human-readable long duration format.
  ///
  /// - If the integer represents seconds, it returns '$this seconds'.
  /// - If the integer represents minutes, it returns '${this} minutes'.
  /// - If the integer represents hours, it returns '${this} hours'.
  /// - If the integer represents days, it returns '${this} days'.
  ///
  /// Example:
  /// ```dart
  /// final seconds = 45;
  /// final minutes = 150;
  /// final hours = 7200;
  /// final days = 129600;
  ///
  /// print(seconds.displayDurationLong); // Output: '45 seconds'
  /// print(minutes.displayDurationLong); // Output: '2 minutes'
  /// print(hours.displayDurationLong);   // Output: '2 hours'
  /// print(days.displayDurationLong);    // Output: '2 days'
  /// ```
  String get displayDurationLong {
    if (this <= 60) return '$this seconds';
    if (this <= 3600) return '${(this / 60).round()} minutes';
    if (this <= 86400) return '${(this / 3600).round()} hours';
    return '${(this / 86400).round()} days';
  }
}
