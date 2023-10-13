// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';

/// The `GroupModel` class extends the `Group` entity and represents a
/// group with additional functionality for data manipulation. It is designed
/// to work with data retrieved from a data source, such as a database.
class GroupModel extends Group {
  /// Creates a `GroupModel` instance with the provided parameters. This constructor
  /// extends the base `Group` class, inheriting its properties and behavior.
  const GroupModel({
    required super.id,
    required super.name,
    required super.courseId,
    required super.members,
    super.lastMessage,
    super.lastMessageSenderName,
    super.lastMessageTimestamp,
    super.groupImageUrl,
  });

  /// Creates an empty `GroupModel` instance with default values.
  GroupModel.empty()
      : this(
          id: '',
          name: '',
          courseId: '',
          members: const [],
          lastMessage: '',
          lastMessageTimestamp: DateTime.now(),
          lastMessageSenderName: '',
          groupImageUrl: '',
        );

  /// Creates a `GroupModel` instance from a `Map` representation of the data.
  /// This constructor extends the base `Group` class, inheriting its properties
  /// and behavior. It's useful for converting data retrieved from a database or
  /// other sources into a `GroupModel`.
  GroupModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          courseId: map['courseId'] as String,
          members: List<String>.from(map['members'] as List<dynamic>),
          // OR
          // members: (map['members'] as List<dynamic>).cast<String>(),
          // OR
          // members: (map['members'] as List<dynamic>)
          //     .map((e) => e as String)
          //     .toList(),
          lastMessage: map['lastMessage'] as String?,
          lastMessageTimestamp:
              (map['lastMessageTimestamp'] as Timestamp?)?.toDate(),
          lastMessageSenderName: map['lastMessageSenderName'] as String?,
          groupImageUrl: map['groupImageUrl'] as String?,
        );

  /// Creates a copy of this `GroupModel` instance with optional property changes.
  /// This method allows for creating a new `GroupModel` instance while preserving
  /// the original data where no changes are specified.
  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    List<String>? members,
    String? lastMessage,
    String? groupImageUrl,
    DateTime? lastMessageTimestamp,
    String? lastMessageSenderName,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courseId: courseId ?? this.courseId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
    );
  }

  /// Converts this `GroupModel` instance to a `Map` representation of the data.
  /// This method is useful for preparing the object for storage in a database or
  /// for serialization when sending data to external services.
  DataMap toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageSenderName': lastMessageSenderName,
      'lastMessageTimestamp':
          lastMessage == null ? null : FieldValue.serverTimestamp(),
      'groupImageUrl': groupImageUrl,
    };
  }
}
