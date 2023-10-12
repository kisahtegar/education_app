import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';

/// A concrete implementation of the [Message] entity, used for representing
/// chat messages in the Firestore database.
class MessageModel extends Message {
  /// Constructs a [MessageModel] with the provided values.
  ///
  /// All parameters are required and are used to initialize the properties
  /// inherited from the [Message] entity.
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.message,
    required super.timestamp,
    required super.groupId,
  });

  /// Constructs an empty [MessageModel] with default values.
  ///
  /// This is typically used when initializing a new message without specific
  /// details. The message content is set to an empty string, and the timestamp
  /// is set to the current date and time.
  MessageModel.empty()
      : this(
          id: '',
          senderId: '',
          message: '',
          groupId: '',
          timestamp: DateTime.now(),
        );

  /// Constructs a [MessageModel] from a Firestore data map.
  ///
  /// This constructor is useful for converting Firestore document data into a
  /// [MessageModel]. The [map] parameter should contain the necessary fields
  /// such as 'id', 'senderId', 'message', 'groupId', and 'timestamp'.
  MessageModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          senderId: map['senderId'] as String,
          message: map['message'] as String,
          groupId: map['groupId'] as String,
          timestamp:
              (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );

  /// Creates a copy of the [MessageModel] with optional property updates.
  ///
  /// This method returns a new [MessageModel] with the same properties as the
  /// original, except for those specified as non-null parameters, which will
  /// be updated in the new instance.
  MessageModel copyWith({
    String? id,
    String? senderId,
    String? message,
    String? groupId,
    DateTime? timestamp,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      message: message ?? this.message,
      groupId: groupId ?? this.groupId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// Converts the [MessageModel] into a Firestore-compatible data map.
  ///
  /// This method returns a map representation of the [MessageModel] that can
  /// be used to store the message in the Firestore database. It includes fields
  /// like 'id', 'senderId', 'message', 'groupId', and 'timestamp'.
  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'message': message,
      'groupId': groupId,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
