import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that wrap its child widget with notification-related functionality.
class NotificationWrapper extends StatefulWidget {
  /// Creates a [NotificationWrapper] widget.
  ///
  /// The [onNotificationSent] callback is called when a notification is sent.
  /// The [child] widget represents the content to be displayed.
  /// The [extraActivity] callback is an optional extra action to be performed.
  const NotificationWrapper({
    required this.onNotificationSent,
    required this.child,
    this.extraActivity,
    super.key,
  });

  /// The child widget representing the content.
  final Widget child;

  /// An optional extra activity callback.
  final VoidCallback? extraActivity;

  /// The callback to be called when a notification is sent.
  final VoidCallback onNotificationSent;

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  bool showingLoader = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        // Close the loading dialog when notifications are cleared.
        if (showingLoader) {
          Navigator.pop(context);
          showingLoader = false;
        }
        if (state is NotificationCleared) {
          // Perform extra activity and call the callback when notifications are
          // cleared.
          widget.extraActivity?.call();
          widget.onNotificationSent();
        } else if (state is SendingNotification) {
          // Show a loading dialog when sending notifications.
          showingLoader = true;
          CoreUtils.showLoadingDialog(context);
        }
      },
      child: widget.child,
    );
  }
}
