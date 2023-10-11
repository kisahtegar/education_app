import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The `QuickAccessHeader` widget displays the header image for the Quick
/// Access tab.
///
/// It shows different images based on the current index provided by the
/// [QuickAccessTabController]. Depending on the index value, it displays
/// different images representing different categories for quick access. These
/// categories can include pot plants and a steam cup, among others.
///
/// Example:
///
/// ```dart
/// QuickAccessHeader()
/// ```
class QuickAccessHeader extends StatelessWidget {
  /// Creates a `QuickAccessHeader` widget.
  const QuickAccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickAccessTabController>(
      builder: (_, controller, __) {
        return Center(
          child: Image.asset(
            controller.currentIndex == 0
                ? MediaRes.bluePotPlant
                : controller.currentIndex == 1
                    ? MediaRes.turquoisePotPlant
                    : MediaRes.steamCup,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
