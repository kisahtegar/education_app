import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/home/presentation/widgets/notification_bell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `HomeAppBar` widget represents the app bar displayed on the home screen.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a `HomeAppBar` widget.
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My Classes'),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        const NotificationBell(),
        Consumer<UserProvider>(
          builder: (_, provider, __) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: provider.user!.profilePic != null
                    ? NetworkImage(provider.user!.profilePic!)
                    : const AssetImage(MediaRes.user) as ImageProvider,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
