import 'package:flutter/material.dart';

/// This widget is designed to create a background with a gradient image
/// overlay, typically used to enhance the visual appearance of a screen or a
/// portion of your app's user interface.
class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    required this.image,
    super.key,
  });

  final Widget child;
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
