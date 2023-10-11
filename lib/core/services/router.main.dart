part of 'router.dart';

/// This code defines the route generation function `generateRoute` responsible
/// for handling different routes within your Flutter application. It constructs
/// the appropriate screens based on the route name and provides necessary
/// dependencies using BlocProvider when required. The `_pageBuilder` function
/// is used to create the page transition with a fade effect.
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            // User is opening the application for the first time.
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            // User is already logged in.
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          // User is not opening the app for the first time and needs to log in.
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );
    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    case CourseDetailsScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailsScreen(settings.arguments! as Course),
        settings: settings,
      );

    case ExamDetailsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ExamDetailsView(settings.arguments! as Exam),
        ),
        settings: settings,
      );
    case ExamHistoryDetailsScreen.routeName:
      return _pageBuilder(
        (_) => ExamHistoryDetailsScreen(settings.arguments! as UserExam),
        settings: settings,
      );
    case ExamView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ChangeNotifierProvider(
            create: (context) => ExamController(
              exam: settings.arguments! as Exam,
            ),
            child: const ExamView(),
          ),
        ),
        settings: settings,
      );
    case AddVideoView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<VideoCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddVideoView(),
        ),
        settings: settings,
      );
    case AddMaterialsView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<MaterialCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddMaterialsView(),
        ),
        settings: settings,
      );
    case AddExamView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<ExamCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddExamView(),
        ),
        settings: settings,
      );
    case VideoPlayerView.routeName:
      return _pageBuilder(
        (_) => VideoPlayerView(videoURL: settings.arguments! as String),
        settings: settings,
      );
    case CourseVideosView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<VideoCubit>(),
          child: CourseVideosView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseMaterialsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<MaterialCubit>(),
          child: CourseMaterialsView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseExamsView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ExamCubit>(),
          child: CourseExamsView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

/// This private function is used to construct a `PageRouteBuilder`. It takes a
/// Widget-building function (`page`) and route settings as parameters. It
/// returns a `PageRouteBuilder` with a fade transition animation when
/// navigating between screens.
PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
