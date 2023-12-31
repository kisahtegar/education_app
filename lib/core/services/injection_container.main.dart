// ignore_for_file: lines_longer_than_80_chars
part of 'injection_container.dart';

/// This file sets up and initializes the dependency injection container (sl)
/// for your app. It configures various services and dependencies related to
/// different app features. By using dependency injection, you can efficiently
/// manage the creation and sharing of these services and dependencies throughout
/// your app, making it more modular and maintainable.

final sl = GetIt.instance;

/// Initializes the dependencies. This function is called at the start of the
/// app to set up all necessary dependencies.
Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initMaterial();
  await _initExam();
  await _initNotifications();
  await _initChat();
}

/// Initializes the onboarding-related dependencies.
Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepoImpl(sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}

/// Initializes the authentication-related dependencies.
Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

/// Initializes the course-related dependencies.
Future<void> _initCourse() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        addCourse: sl(),
        getCourses: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(sl()))
    ..registerLazySingleton(() => GetCourses(sl()))
    ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(sl()))
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
        firebaseAuth: sl(),
      ),
    );
}

/// Initializes the video-related dependencies.
Future<void> _initVideo() async {
  sl
    ..registerFactory(() => VideoCubit(addVideo: sl(), getVideos: sl()))
    ..registerLazySingleton(() => AddVideo(sl()))
    ..registerLazySingleton(() => GetVideos(sl()))
    ..registerLazySingleton<VideoRepo>(() => VideoRepoImpl(sl()))
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: sl(), auth: sl(), storage: sl()),
    );
}

/// Initializes the material-related dependencies.
Future<void> _initMaterial() async {
  sl
    ..registerFactory(
      () => MaterialCubit(
        addMaterial: sl(),
        getMaterials: sl(),
      ),
    )
    ..registerLazySingleton(() => AddMaterial(sl()))
    ..registerLazySingleton(() => GetMaterials(sl()))
    ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(sl()))
    ..registerLazySingleton<MaterialRemoteDataSrc>(
      () => MaterialRemoteDataSrcImpl(
        firestore: sl(),
        auth: sl(),
        storage: sl(),
      ),
    )
    ..registerFactory(() => ResourceController(storage: sl(), prefs: sl()));
}

/// Initializes the exam-related dependencies.
Future<void> _initExam() async {
  sl
    ..registerFactory(
      () => ExamCubit(
        getExamQuestions: sl(),
        getExams: sl(),
        submitExam: sl(),
        updateExam: sl(),
        uploadExam: sl(),
        getUserCourseExams: sl(),
        getUserExams: sl(),
      ),
    )
    ..registerLazySingleton(() => GetExamQuestions(sl()))
    ..registerLazySingleton(() => GetExams(sl()))
    ..registerLazySingleton(() => SubmitExam(sl()))
    ..registerLazySingleton(() => UpdateExam(sl()))
    ..registerLazySingleton(() => UploadExam(sl()))
    ..registerLazySingleton(() => GetUserCourseExams(sl()))
    ..registerLazySingleton(() => GetUserExams(sl()))
    ..registerLazySingleton<ExamRepo>(() => ExamRepoImpl(sl()))
    ..registerLazySingleton<ExamRemoteDataSrc>(
      () => ExamRemoteDataSrcImpl(auth: sl(), firestore: sl()),
    );
}

/// Initializes the notification-related dependencies.
Future<void> _initNotifications() async {
  sl
    ..registerFactory(
      () => NotificationCubit(
        clear: sl(),
        clearAll: sl(),
        getNotifications: sl(),
        markAsRead: sl(),
        sendNotification: sl(),
      ),
    )
    ..registerLazySingleton(() => Clear(sl()))
    ..registerLazySingleton(() => ClearAll(sl()))
    ..registerLazySingleton(() => GetNotifications(sl()))
    ..registerLazySingleton(() => MarkAsRead(sl()))
    ..registerLazySingleton(() => SendNotification(sl()))
    ..registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(sl()))
    ..registerLazySingleton<NotificationRemoteDataSrc>(
      () => NotificationRemoteDataSrcImpl(firestore: sl(), auth: sl()),
    );
}

/// Initializes the chat-related dependencies.
Future<void> _initChat() async {
  sl
    ..registerFactory(
      () => ChatCubit(
        getGroups: sl(),
        getMessages: sl(),
        getUserById: sl(),
        joinGroup: sl(),
        leaveGroup: sl(),
        sendMessage: sl(),
      ),
    )
    ..registerLazySingleton(() => GetGroups(sl()))
    ..registerLazySingleton(() => GetMessages(sl()))
    ..registerLazySingleton(() => GetUserById(sl()))
    ..registerLazySingleton(() => JoinGroup(sl()))
    ..registerLazySingleton(() => LeaveGroup(sl()))
    ..registerLazySingleton(() => SendMessage(sl()))
    ..registerLazySingleton<ChatRepo>(() => ChatRepoImpl(sl()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(firestore: sl(), auth: sl()),
    );
}
