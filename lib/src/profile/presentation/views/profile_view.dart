import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/profile/presentation/refactors/profile_body.dart';
import 'package:education_app/src/profile/presentation/refactors/profile_header.dart';
import 'package:education_app/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

/// The `ProfileView` widget represents the user's profile page, which displays
/// user-specific information such as their profile picture, full name, bio,
/// the number of courses they are enrolled in, their score, followers, and
/// following.
///
/// This widget is organized into several components:
///
/// 1. **AppBar**: The top app bar that provides navigation and actions for the
///    profile view. It is implemented using the `[ProfileAppBar]` widget.
///
/// 2. **Background**: The background of the profile view, displayed as a
///    gradient image. This is implemented using the `[GradientBackground]`
///    widget with the provided image.
///
/// 3. **Content**: The main content of the profile view, which includes the
///    user's profile picture, full name, biography, and user-related statistic.
///    This content is structured using `[ListView]` and includes the
///    `[ProfileHeader]` widget for the user's profile picture and basic
///    information and the `[ProfileBody]` widget for displaying user-related
///    statistics.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
