import 'package:education_app/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:education_app/core/common/app/providers/notifications_notifier.dart';
import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/services/router.dart';
import 'package:education_app/firebase_options.dart';
import 'package:education_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The `main` function initializes the Flutter app and sets up Firebase
/// services and authentication providers.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the provided options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure authentication providers, including EmailAuthProvider for
  // password reset functionality.
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);

  // Initialize other app dependencies.
  await init();

  // Run the app.
  runApp(const MyApp());
}

/// The `MyApp` widget is the root of the Flutter app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the UserProvider for managing user-related data.
        ChangeNotifierProvider(create: (_) => UserProvider()),

        // Provide the DashboardController for controlling dashboard state.
        ChangeNotifierProvider(create: (_) => DashboardController()),

        // Provide the CourseOfTheDayNotifier for managing and notifying the
        // "Course of the Day" within the application.
        ChangeNotifierProvider(create: (_) => CourseOfTheDayNotifier()),

        /// Provides the [NotificationsNotifier] for managing and handling
        /// notifications within the application, using the provided
        /// [SharedPreferences] instance [sl].
        ChangeNotifierProvider(
          create: (_) => NotificationsNotifier(
            sl<SharedPreferences>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          colorScheme:
              ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        ),

        // Define the route generation function.
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
