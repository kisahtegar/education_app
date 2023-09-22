import 'package:badges/badges.dart';
import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/src/notifications/presentation/widgets/no_notifications.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_options.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

/// A StatefulWidget that displays a list of notifications.
class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

/// The state of the [NotificationsView] widget.
class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();

    // Fetches notifications from the notification cubit when the widget is
    // initialized.
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'), // Title of the app bar.
        centerTitle: false,
        leading: const NestedBackButton(), // Back button.
        actions: const [NotificationOptions()], // Notification options.
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          // Handles error state by displaying a snackbar and returning to the
          // previous screen.
          if (state is NotificationError) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotifications) {
            // Displays a loading view while fetching notifications.
            return const LoadingView();
          } else if (state is NotificationsLoaded &&
              state.notifications.isEmpty) {
            // Displays a message when there are no notifications.
            return const NoNotifications();
          } else if (state is NotificationsLoaded) {
            // Builds a list of notification tiles.
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (_, index) {
                final notification = state.notifications[index];
                return Badge(
                  showBadge: !notification.seen,
                  position: BadgePosition.topEnd(top: 30, end: 20),
                  child: BlocProvider(
                    create: (context) => sl<NotificationCubit>(),
                    child: NotificationTile(notification),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
