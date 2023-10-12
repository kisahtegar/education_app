import 'package:equatable/equatable.dart';

/// Represents a message within a group chat.
///
/// A `Message` is a data model that holds information about a chat message,
/// including its unique identifier, sender ID, message content, timestamp, and
/// group ID. This class also provides an `empty` constructor for creating a
/// default message with empty values and the current timestamp.
///
/// Example:
/// ```dart
/// final message = Message(
///   id: '1',
///   senderId: 'user123',
///   message: 'Hello, how are you?',
///   groupId: 'group456',
///   timestamp: DateTime.now(),
/// );
/// ```
class Message extends Equatable {
  /// Creates a new `Message` with the provided details.
  const Message({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.groupId,
  });

  /// Creates an empty `Message` with default values and the current timestamp.
  Message.empty()
      : id = '',
        senderId = '',
        message = '',
        groupId = '',
        timestamp = DateTime.now();

  /// A unique identifier for the message.
  final String id;

  /// The identifier of the message sender.
  final String senderId;

  /// The content of the message.
  final String message;

  /// The unique identifier of the group or chat where the message belongs.
  final String groupId;

  /// The timestamp when the message was sent.
  final DateTime timestamp;

  /// Generates a string representation of the [Message] instance.
  @override
  String toString() {
    return 'Message{id: $id, senderId: $senderId, message: $message, groupId: '
        '$groupId, timestamp: $timestamp}';
  }

  /// Defines the list of properties used for equality comparisons.
  @override
  List<Object> get props => [id, groupId];
}
