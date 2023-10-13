import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/src/chat/data/models/message_model.dart';
import 'package:education_app/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

/// The `ChatInputField` widget provides a text input field and send button
/// for sending messages in a chat conversation. It is used to enter text
/// messages and interact with the [ChatCubit] to send messages to a chat group.
///
/// Example:
/// ```dart
/// ChatInputField(groupId: 'group123');
/// ```
class ChatInputField extends StatefulWidget {
  /// Creates a [ChatInputField] with the specified [groupId].
  ///
  /// The [groupId] is used to identify the chat group where the message will
  /// be sent.
  const ChatInputField({required this.groupId, super.key});

  /// The ID of the chat group to which the message will be sent.
  final String groupId;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Message',
          hintStyle: const TextStyle(
            color: Color(0xFF9FA5BB),
          ),
          filled: true,
          fillColor: Colours.chatFieldColour,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Transform.scale(
            scale: .75,
            child: IconButton.filled(
              padding: EdgeInsets.zero,
              icon: const Icon(IconlyLight.send, color: Colors.white),
              onPressed: () {
                final message = controller.text.trim();
                if (message.isEmpty) return;
                controller.clear();
                focusNode.unfocus();
                context.read<ChatCubit>().sendMessage(
                      MessageModel.empty().copyWith(
                        message: message,
                        senderId: context.currentUser!.uid,
                        groupId: widget.groupId,
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
