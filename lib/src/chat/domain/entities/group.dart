// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// The `Group` class represents a group entity with various properties.
class Group extends Equatable {
  /// Creates a `Group` instance with the provided parameters.
  const Group({
    required this.id,
    required this.name,
    required this.courseId,
    required this.members,
    this.lastMessage,
    this.groupImageUrl,
    this.lastMessageTimestamp,
    this.lastMessageSenderName,
  });

  /// Creates an empty `Group` instance with default values.
  ///
  /// This constructor can be used for creating a placeholder or default course
  /// model with empty or default values for various properties.
  const Group.empty()
      : this(
          id: '',
          name: '',
          courseId: '',
          members: const [],
          lastMessage: null,
          groupImageUrl: null,
          lastMessageTimestamp: null,
          lastMessageSenderName: null,
        );

  final String id;
  final String name;
  final String courseId;
  final List<String> members;
  final String? lastMessage;
  final String? groupImageUrl;
  final DateTime? lastMessageTimestamp;
  final String? lastMessageSenderName;

  @override
  List<Object?> get props => [id, name, courseId];
}
