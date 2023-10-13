import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:education_app/src/chat/presentation/refactors/chat_app_bar.dart';
import 'package:education_app/src/chat/presentation/widgets/chat_input_field.dart';
import 'package:education_app/src/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A chat view widget for displaying a chat conversation.
///
/// The `ChatView` widget is used to display a chat conversation in the app.
/// It includes a custom app bar, chat messages, and an input field for typing
/// and sending new messages. This widget manages the display of chat messages
/// and user interactions.
///
/// Example:
/// ```dart
/// ChatView(group: chatGroup);
/// ```
class ChatView extends StatefulWidget {
  /// Creates a [ChatView] for the specified [group].
  ///
  /// The [group] represents the chat group for which the chat conversation
  /// should be displayed.
  const ChatView({required this.group, super.key});

  /// The chat group for which the chat conversation is displayed.
  final Group group;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  // Flag to track whether a dialog is currently being displayed
  bool showingDialog = false;

  // List to store chat messages
  List<Message> messages = [];

  // Flag to indicate whether the input field for sending messages is visible
  bool showInputField = false;

  @override
  void initState() {
    super.initState();
    // Triggers the retrieval of chat messages for the specified group using the
    // ChatCubit
    context.read<ChatCubit>().getMessages(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(group: widget.group),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, state) {
          if (showingDialog) {
            // Dismisses any dialog that might be displayed
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is ChatError) {
            // Displays a snack bar with an error message
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is LeavingGroup) {
            // Displays a loading dialog when leaving a group
            showingDialog = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is LeftGroup) {
            // Navigates back to the previous screen after leaving the group
            context.pop();
          } else if (state is MessagesLoaded) {
            // Updates the messages and shows the input field
            setState(() {
              messages = state.messages;
              showInputField = true;
            });
          }
        },
        builder: (context, state) {
          if (state is LoadingMessages) {
            // Shows a loading view when messages are being loaded
            return const LoadingView();
          } else if (state is MessagesLoaded ||
              showInputField ||
              messages.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (_, index) {
                      final message = messages[index];
                      final previousMessage =
                          index > 0 ? messages[index - 1] : null;

                      // Determines whether to show sender information in the
                      // message bubble
                      final showSenderInfo = previousMessage == null ||
                          previousMessage.senderId != message.senderId;
                      return BlocProvider(
                        create: (_) => sl<ChatCubit>(),
                        child: MessageBubble(
                          message,
                          showSenderInfo: showSenderInfo,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1),
                BlocProvider(
                  create: (_) => sl<ChatCubit>(),
                  child: ChatInputField(groupId: widget.group.id),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
