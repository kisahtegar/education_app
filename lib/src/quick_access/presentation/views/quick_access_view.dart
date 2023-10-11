import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/quick_access/presentation/refactors/quick_access_app_bar.dart';
import 'package:education_app/src/quick_access/presentation/refactors/quick_access_header.dart';
import 'package:education_app/src/quick_access/presentation/refactors/quick_access_tab_bar.dart';
import 'package:education_app/src/quick_access/presentation/refactors/quick_access_tab_body.dart';
import 'package:flutter/material.dart';

/// The `QuickAccessView` widget is the main view for quick access to course
/// materials and exams.
///
/// This screen provides access to course materials and exams, displaying a tab
/// bar with three options: Document, Exam, and Passed.
///
/// Example:
///
/// ```dart
/// QuickAccessView()
/// ```
class QuickAccessView extends StatelessWidget {
  /// Creates a `QuickAccessView` widget.
  const QuickAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: QuickAccessAppBar(),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: Center(
          child: Column(
            children: [
              Expanded(flex: 2, child: QuickAccessHeader()),
              Expanded(child: QuickAccessTabBar()),
              Expanded(flex: 2, child: QuickAccessTabBody()),
            ],
          ),
        ),
      ),
    );
  }
}
