import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `ProfileHeader` widget displays the user's profile information at the
/// top of the user's profile view. It includes the user's profile picture,
/// full name, and optional bio.
///
/// This widget utilizes a [Consumer] widget to access user-related data provide
/// by a [UserProvider]. It dynamically updates the profile information based on
/// the user's data, including their profile picture, full name, and bio.
///
/// Components of the `ProfileHeader`:
///
/// 1. **Profile Picture**: Displays the user's profile picture as a circular
///    avatar. If the user doesn't have a profile picture, it displays a default
///    user image.
///
/// 2. **Full Name**: Shows the user's full name below the profile picture. If
///    the user's full name is not available, it displays 'No User'.
///
/// 3. **Bio**: Displays an optional user bio if available. The bio is shown in
///    a styled text widget, and it adjusts its layout based on the bio content
///    length.
///
/// This widget provides a visually appealing and informative header for a
/// user's profile.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.user) as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'No User',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * .15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
