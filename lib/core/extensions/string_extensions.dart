/// The `StringExt` extension provides additional functionality for the `String`
/// class.
///
/// Dart extensions allow you to add new methods to existing classes without
/// modifying their source code.
extension StringExt on String {
  /// Obscures an email address for privacy or security purposes by partially
  /// hiding it.
  ///
  /// It splits the email address into the username and domain parts, obscures
  /// the username, and displays only the first and last characters.
  ///
  /// Example:
  /// ```dart
  /// final emailAddress = 'example.email@example.com';
  /// final obscuredEmail = emailAddress.obscureEmail;
  /// print(obscuredEmail); // Output: 'e****l@example.com'
  /// ```
  String get obscureEmail {
    // split the email into username and domain
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    // Obscure the username and display only the first and last characters
    username = '${username[0]}****${username[username.length - 1]}';
    return '$username@$domain';
  }

  /// Checks if the `String` represents a YouTube video URL.
  ///
  /// Example:
  /// ```dart
  /// final videoUrl = 'https://www.youtube.com/watch?v=abc123';
  /// final isYouTube = videoUrl.isYoutubeVideo; // Output: true
  /// ```
  bool get isYoutubeVideo =>
      contains('youtube.com/watch?v=') || contains('youtu.be/');
}
