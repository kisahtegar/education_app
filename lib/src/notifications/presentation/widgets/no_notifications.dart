import 'package:education_app/core/res/media_res.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget that displays a "No Notifications" message with an animation.
class NoNotifications extends StatelessWidget {
  const NoNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(MediaRes.noNotifications));
  }
}
