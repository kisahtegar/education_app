// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/app/providers/tab_navigator.dart';
import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This extension simplifies common app development tasks by providing easy
/// access to essential functionality from the `BuildContext`. It enhances code
/// readability and promotes cleaner widget build methods.
extension ContextExt on BuildContext {
  /// Access the current `ThemeData` from the nearest `Theme` widget, allowing
  /// you to retrieve theme-related properties like colors and text styles.
  ThemeData get theme => Theme.of(this);

  /// Get the current `MediaQueryData`, which contains screen information like
  /// size and orientation, facilitating responsive layout design.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Shorthand for accessing the screen size (dimensions) from `mediaQuery`.
  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;

  /// Access a `UserProvider` object from the nearest ancestor widget using the
  /// `read` method from `Provider`. Useful for user-related data or state.
  UserProvider get userProvider => read<UserProvider>();

  /// Easily retrieve the current user object (`LocalUser`) stored in the
  /// `UserProvider`. Simplifies accessing user data.
  LocalUser? get currentUser => userProvider.user;

  /// Access a `TabNavigator` object from the nearest ancestor widget using the
  /// `read` method from `Provider`. Useful for navigation actions in your app.
  TabNavigator get tabNavigator => read<TabNavigator>();

  /// Trigger the navigation stack's pop operation, typically used for navigating
  /// back to the previous screen or page.
  void pop() => tabNavigator.pop();

  /// Push a new screen or page onto the navigation stack by calling `push()` on
  /// the `TabNavigator`. Provide a widget as a child of a new `TabItem`.
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}
