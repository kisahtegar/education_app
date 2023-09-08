/// The `IntExt` extension adds functionality to integers for estimating values.
extension IntExt on int {
  /// Estimates the value, providing a human-friendly representation.
  ///
  /// If the integer is 10 or less, it returns the integer itself as a string.
  /// For integers greater than 10, it rounds to the nearest multiple of 10 and
  /// returns a string like "over 10" or "over 20" based on the rounded value.
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
}
