import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This extension simplifies common tasks in app development, such as accessing
/// themes, media queries, user data, and navigation functionality from the
/// `BuildContext`. It promotes cleaner and more concise code within your widget
/// build methods.
extension ContextExt on BuildContext {
  /// This property allows you to access the current `ThemeData` from the `Theme`
  /// widget that is nearest to the current `BuildContext`. It provides access to
  /// the theme's colors, text styles, and other styling properties.
  ThemeData get theme => Theme.of(this);

  /// This property gives you access to the current `MediaQueryData`, which
  /// contains information about the device's screen size, orientation, and
  /// more. It's useful for creating responsive layouts.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// This property is a shorthand for accessing the screen size (dimensions)
  /// from the `mediaQuery`.
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  /// This property allows you to access a `UserProvider` object from the nearest
  /// ancestor widget using the `read` method provided by `Provider`. It's useful
  /// for accessing user-related data or state.
  UserProvider get userProvider => read<UserProvider>();

  /// This property provides easy access to the current user object (of type
  /// `LocalUser`) stored in the `UserProvider`. It simplifies the process of
  /// retrieving the current user's data.
  LocalUser? get currentUser => userProvider.user;

  /// This property allows you to access a `TabNavigator` object from the nearest
  /// ancestor widget using the `read` method provided by `Provider`. It's useful
  /// for performing navigation actions within your app, such as pushing or
  /// popping screens/pages.
  TabNavigator get tabNavigator => read<TabNavigator>();

  /// This method calls the `pop()` method on the `TabNavigator`. It's a convenient
  /// way to trigger the navigation stack's pop operation, typically used for
  /// navigating back to the previous screen or page.
  void pop() => tabNavigator.pop();

  /// This method calls the push() method on the TabNavigator with the provided
  /// Widget as the child of a new TabItem. It simplifies the process of pushing
  /// a new screen or page onto the navigation stack.
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
