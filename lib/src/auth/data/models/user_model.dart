import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

/// `LocalUserModel` is a concrete implementation of the `LocalUser` entity,
/// providing constructors for creating instances, a method for updating
/// property values immutably, and a method for converting instances to map
/// representations. It serves as a data model for representing and manipulating
/// user data within the application.
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
  /// all properties. It is useful for initializing an empty user model when
  /// needed.
  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  /// This constructor takes a `DataMap` (usually a map of data obtained from a
  /// data source like Firestore) and constructs a `LocalUserModel` instance
  /// from the map's values. It maps the properties from the map to the
  /// corresponding properties of the `LocalUserModel`. This constructor is
  /// useful when deserializing data.
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

  /// The `copyWith` method allows to create a new instance of `LocalUserModel`
  /// with updated values for specific properties. It takes optional parameters
  /// for properties you want to modify and returns a new instance with the
  /// modified values. This is a common pattern for immutability and updating
  /// objects.
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

  /// The `toMap` method convert the `LocalUserModel` instance into a `DataMap`.
  /// It maps the object's properties to `key-value` pairs in a map. This method
  /// is typically used when serializing the user model to store it in a data
  /// source.
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
