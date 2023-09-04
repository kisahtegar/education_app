import 'package:equatable/equatable.dart';

/// `LocalUser` entity is used to encapsulate user data and make it available
/// for use throughout the application. It serves as a structured way to
/// represent and manage user information, facilitating tasks such as
/// displaying user profiles and interacting with other users within the app.
class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.groupIds = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
    this.bio,
  });

  /// `LocalUser` includes a named constructor `empty` that creates an instance
  /// with default or empty values for all properties. This is useful for
  /// initializing an empty user when needed.
  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
          profilePic: '',
          bio: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          following: const [],
          followers: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  /// The `props` method is overridden to provide a list of object properties
  /// that should be considered when determining the equality of two `LocalUser`
  /// instances. In this case, it includes the `uid` and `email`.
  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        bio,
        points,
        fullName,
        groupIds.length,
        enrolledCourseIds.length,
        following.length,
        followers.length,
      ];

  /// This method is overridden to provide a human-readable representation of
  /// the `LocalUser` instance.
  @override
  String toString() {
    return 'LocalUser{uid:  $uid, email: $email, bio: $bio, points: $points, '
        'fullName: $fullName}';
  }
}
