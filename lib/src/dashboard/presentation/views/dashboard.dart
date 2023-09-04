// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:education_app/src/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

/// The `Dashboard` widget is responsible for displaying the main user interface of
/// the app's dashboard. It listens to changes in user data using a `StreamBuilder`,
/// controls the active screen with an `IndexedStack`, and provides navigation
/// using a `BottomNavigationBar`. It also updates the user data in the `UserProvider`
/// when new data is available.
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  /// The route name used to navigate to the dashboard screen.
  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    // Set the preferred screen orientations to portrait-up and portrait-down.
    // This means that the app will only allow portrait orientations, preventing
    // the screen from rotating to landscape mode.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          // Update the user data in the [UserProvider] using
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<DashboardController>(
          // Listens for changes in the DashboardController. When the controller's
          // state changes, it rebuilds its child widget with the updated data.
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                // This widget is used to manage multiple screens or pages that
                // can be displayed in the dashboard. The [IndexedStack] widget
                // shows only one child at a time based on the [controller.currentIndex].
                // The [controller.screens] list contains the screens to be displayed.
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                // Displays tabs at the bottom of the screen and allows users to
                // switch between different sections.
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                backgroundColor: Colors.white,
                elevation: 8,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 0
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Home',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.document
                          : IconlyLight.document,
                      color: controller.currentIndex == 1
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Materials',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.chat
                          : IconlyLight.chat,
                      color: controller.currentIndex == 2
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Chat',
                    backgroundColor: Colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 3
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 3
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'User',
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
