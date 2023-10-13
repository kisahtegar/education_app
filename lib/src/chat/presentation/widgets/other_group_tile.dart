import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A custom tile widget for displaying information about chat groups that the
/// user can join.
///
/// The `OtherGroupTile` widget is used to display information about chat groups
/// that the user can join. It provides details about the group, including the
/// group's name, an option to view the group image, and a 'Join' button for
/// joining the group.
///
/// This widget encourages user interaction by allowing them to join the
/// displayed chat groups.
///
/// Example:
/// ```dart
/// OtherGroupTile(
///   group: chatGroup,
/// )
/// ```
class OtherGroupTile extends StatelessWidget {
  /// Creates an [OtherGroupTile] with the specified [group].
  const OtherGroupTile(this.group, {super.key});

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
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.primaryColour,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          context.read<ChatCubit>().joinGroup(
                groupId: group.id,
                userId: context.currentUser!.uid,
              );
        },
        child: const Text('Join'),
      ),
    );
  }
}
