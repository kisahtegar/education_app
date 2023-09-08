import 'package:equatable/equatable.dart';

/// The `LocalUser` entity encapsulates user data for use throughout the
/// application. It provides a structured representation of user information,
/// facilitating tasks such as displaying user profiles and interacting with
/// other users within the app.
class LocalUser extends Equatable {
  /// Constructs a `LocalUser` instance with the specified properties.
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

  /// Creates an instance of `LocalUser` with default or empty values for all
  /// properties. Useful for initializing an empty user when needed.
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

  /// The unique identifier associated with the user.
  final String uid;

  /// The email address of the user.
  final String email;

  /// The user's profile picture URL.
  final String? profilePic;

  /// A short user bio or description.
  final String? bio;

  /// The user's earned points or rewards.
  final int points;

  /// The full name of the user.
  final String fullName;

  /// A list of group IDs the user is a member of.
  final List<String> groupIds;

  /// A list of enrolled course IDs associated with the user.
  final List<String> enrolledCourseIds;

  /// A list of user IDs the user is following.
  final List<String> following;

  /// A list of user IDs following the user.
  final List<String> followers;

  // Checks if the user has administrator privileges.
  bool get isAdmin => email == 'frocrazy123@gmail.com';

  /// The `props` method is overridden to provide a list of object properties
  /// that should be considered when determining the equality of two `LocalUser`
  /// instances.
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
