/// This code defines an extension for the `String` class called `StringExt`.
/// `Extensions` in Dart allow you to add new functionality to existing classes
/// without modifying their source code.
extension StringExt on String {
  /// easily obscure email addresses by calling `obscureEmail` on a `String`
  /// containing an email, making it useful for privacy or security purposes
  /// when displaying email addresses in a partially hidden format.
  String get obscureEmail {
    // split the email into username and domain
    final index = indexOf('@');
    var username = substring(0, index);
    final domain = substring(index + 1);

    // Obscure the username and display only the first and last characters
    username = '${username[0]}****${username[username.length - 1]}';
    return '$username@$domain';
  }
}