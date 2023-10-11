import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `QuickAccessAppBar` widget is used to display the app bar in the Quick
/// Access tab.
///
/// It shows the title, which in this case is 'Materials' and the user's profile
/// picture as a `CircleAvatar`. The user's profile picture is provided by the
/// [UserProvider] and is displayed as a network image if available, falling
/// back to a default image if not.
///
/// Example:
///
/// ```dart
/// QuickAccessAppBar()
/// ```
class QuickAccessAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QuickAccessAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Materials'),
      centerTitle: false,
      actions: [
        Consumer<UserProvider>(
          builder: (_, provider, __) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
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
