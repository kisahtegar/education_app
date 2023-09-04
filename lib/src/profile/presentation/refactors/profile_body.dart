import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

/// The `ProfileBody` widget displays various user-related information in a
/// user's profile view. It uses data provided by a `UserProvider` to populate
/// user-specific details such as enrolled courses, points, followers, and
/// following.
///
/// This widget consists of the following sections:
///
/// 1. **Courses**: Displays the number of courses the user is enrolled in.
///    It is represented by an [UserInfoCard] with a document icon and a theme
///    color that corresponds to the subject of the courses (e.g., physics).
///
/// 2. **Score**: Shows the user's points or score, often related to their
///    performance on educational activities. It is represented by an
///    [UserInfoCard] with an icon and a theme color.
///
/// 3. **Followers**: Displays the number of users who are following the current
///    user. It is represented by an [UserInfoCard] with a user icon and a theme
///    color (e.g., biology).
///
/// 4. **Following**: Shows the number of users whom the current user is
///    following. Similar to "Followers," it is represented by an [UserInfoCard]
///    with a user icon and a theme color (e.g., chemistry).
///
/// These sections provide a quick overview of the user's profile statistics.
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColour: Colours.physicsTileColour,
                    infoIcon: const Icon(
                      IconlyLight.document,
                      size: 24,
                      color: Color(0xFF767DFF),
                    ),
                    infoTitle: 'Courses',
                    infoValue: user!.enrolledCourseIds.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColour: Colours.languageTileColour,
                    infoIcon: Image.asset(
                      MediaRes.scoreboard,
                      height: 24,
                      width: 24,
                    ),
                    infoTitle: 'Score',
                    infoValue: user.points.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColour: Colours.biologyTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFF56AEFF),
                      size: 24,
                    ),
                    infoTitle: 'Followers',
                    infoValue: user.followers.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColour: Colours.chemistryTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFFFF84AA),
                      size: 24,
                    ),
                    infoTitle: 'Following',
                    infoValue: user.following.length.toString(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
