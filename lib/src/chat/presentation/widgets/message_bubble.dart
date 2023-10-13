import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A chat message bubble widget that displays chat messages in a conversation.
///
/// The `MessageBubble` widget is used to display chat messages in a chat
/// conversation. It displays the sender's information, including their profile
/// picture and name, and the chat message itself. The widget can differentiate
/// between messages sent by the current user and messages sent by others.
///
/// Example:
/// ```dart
/// MessageBubble(
///   message: chatMessage,
///   showSenderInfo: true,
/// )
/// ```
class MessageBubble extends StatefulWidget {
  /// Creates a [MessageBubble] with the specified [message] and
  /// [showSenderInfo] flag.
  ///
  /// The [message] represents the chat message to display, and [showSenderInfo]
  /// is a flag to indicate whether to display sender information or not.
  const MessageBubble(this.message, {required this.showSenderInfo, super.key});

  /// The chat message to be displayed within the bubble.
  final Message message;

  /// A flag indicating whether to show sender information (avatar and name) in
  /// the bubble.
  final bool showSenderInfo;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  LocalUser? user;

  late bool isCurrentUser;

  @override
  void initState() {
    // Check if the [senderId] of the [widget.message] matches the [uid] of the
    // current user in the app's context.
    if (widget.message.senderId == context.currentUser!.uid) {
      // Assign the [user] property the value of the current user stored in the
      // app's context.
      user = context.currentUser;

      // Set [isCurrentUser] to [true] since the sender of the message is the
      // current user.
      isCurrentUser = true;
    } else {
      // If the [senderId] does not match the current user's [uid], set
      // [isCurrentUser] to [false] to indicate that the sender is not the
      // current user.
      isCurrentUser = false;

      // Request user information for the sender from the [ChatCubit] using the
      // [getUser] method, and store the result in the [user] property.
      context.read<ChatCubit>().getUser(widget.message.senderId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (_, state) {
        // Check if the [state] is an instance of [UserFound] and if the [user]
        // property is currently null.
        if (state is UserFound && user == null) {
          // Invoke the [setState] method to update the widget's internal state.
          setState(() {
            // Assign the [user] property with the user found in the [state].
            user = state.user;
          });
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width - 45),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (widget.showSenderInfo && !isCurrentUser)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      user == null || (user!.profilePic == null)
                          ? kDefaultAvatar
                          : user!.profilePic!,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user == null ? 'Unknown User' : user!.fullName,
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.only(top: 4, left: isCurrentUser ? 0 : 20),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isCurrentUser
                    ? Colours.currentUserChatBubbleColour
                    : Colours.otherUserChatBubbleColour,
              ),
              child: Text(
                widget.message.message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
