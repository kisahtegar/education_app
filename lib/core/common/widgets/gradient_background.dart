import 'package:flutter/material.dart';

/// The `GradientBackground` widget is used to create a visually appealing
/// background by overlaying a gradient on top of an image. This widget is
/// commonly used to enhance the overall visual experience of a screen or a
/// specific section of your app's user interface.
class GradientBackground extends StatelessWidget {
  /// Creates a `GradientBackground` with the specified `child` and `image`.
  ///
  /// The `child` represents the content that will be displayed on top of the
  /// gradient background. The `image` parameter specifies the path to the image
  /// used as the background, and the gradient overlay enhances its visual
  /// appearance.
  const GradientBackground({
    required this.child,
    required this.image,
    super.key,
  });

  /// The widget that will be displayed on top of the gradient background.
  final Widget child;

  /// The path to the image used as the background, which is enhanced by the
  /// gradient overlay.
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
