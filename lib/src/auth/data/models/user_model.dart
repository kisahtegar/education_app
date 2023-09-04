// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

/// Represents a concrete implementation of the `LocalUser` entity. It provides
/// constructors for creating instances, methods for updating property values
/// immutably, and converting instances to map representations. This class serves
/// as a data model for representing and manipulating user data within the
/// application.
class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.profilePic,
    super.bio,
  });

  /// Creates an instance of `LocalUserModel` with default or empty values for
  /// all properties. Useful for initializing an empty user model when needed.
  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  /// Constructs a `LocalUserModel` instance from a `DataMap`, typically obtained
  /// from a data source like Firestore. It maps properties from the map to the
  /// corresponding properties of the `LocalUserModel`, useful for deserialization.
  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
          enrolledCourseIds:
              (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
        );

  /// Creates a new instance of `LocalUserModel` with updated values for specific
  /// properties using the `copyWith` method. This pattern ensures immutability
  /// and allows for updating objects.
  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  /// Converts the `LocalUserModel` instance into a `DataMap` by mapping its
  /// properties to key-value pairs in a map. Typically used for serializing
  /// the user model to store it in a data source.
  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }
}
