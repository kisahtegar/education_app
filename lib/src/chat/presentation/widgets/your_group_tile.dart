import 'package:education_app/core/common/widgets/time_text.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:education_app/src/chat/presentation/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A custom tile widget for displaying user's chat group information.
///
/// The `YourGroupTile` widget is used to display detailed information about a
/// user's chat group, including the group's name, last message sender, last
/// message content, and the group's image. It also provides interaction with
/// the chat view when tapped.
///
/// This widget offers a consistent and informative representation of a chat
/// group, ensuring a great user experience in the application.
///
/// Example:
/// ```dart
/// YourGroupTile(
///   group: yourGroupObject,
/// )
/// ```
class YourGroupTile extends StatelessWidget {
  /// Creates a [YourGroupTile] with the specified [group].
  const YourGroupTile(this.group, {super.key});

  /// The chat group to display within the tile.
  final Group group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.network(group.groupImageUrl!),
        ),
      ),
      subtitle: group.lastMessage != null
          ? RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '~ ${group.lastMessageSenderName}: ',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '${group.lastMessage}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : null,
      trailing: group.lastMessage != null
          ? TimeText(
              group.lastMessageTimestamp!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      onTap: () {
        context.push(
          BlocProvider(
            create: (_) => sl<ChatCubit>(),
            child: ChatView(group: group),
          ),
        );
      },
    );
  }
}
