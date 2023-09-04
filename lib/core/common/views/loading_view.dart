import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// The `LoadingView` widget is designed to display a loading indicator
/// within the application. It provides a centered loading spinner to inform
/// users that an operation is in progress.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator(
          /// Sets the loading indicator color to match the secondary color
          /// scheme of the current app theme.
          valueColor: AlwaysStoppedAnimation<Color>(
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
