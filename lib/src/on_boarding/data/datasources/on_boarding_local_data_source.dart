// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The `OnBoardingLocalDataSource` abstract class defines a contract that any
/// concrete implementation must adhere to when working with onboarding-related
/// data in the application. This abstraction helps maintain code consistency,
/// separation of concerns, and flexibility when dealing with different local
/// storage options.
abstract class OnBoardingLocalDataSource {
  /// Constructs an instance of [OnBoardingLocalDataSource].
  const OnBoardingLocalDataSource();

  /// Caches the information indicating whether a user is a first-time user.
  ///
  /// Throws a [CacheException] if an error occurs during the caching process.
  Future<void> cacheFirstTimer();

  /// Checks if a user is a first-time user.
  ///
  /// Returns `true` if the user is a first-time user or if the key is not found,
  /// and `false` if the user is not a first-time user.
  ///
  /// Throws a [CacheException] if an error occurs during the retrieval process.
  Future<bool> checkIfUserIsFirstTimer();
}

/// The key used to access and store the first-time user information in the
/// local storage (SharedPreferences).
const kFirstTimerKey = 'first_timer';

/// The `OnBoardingLocalDataSrcImpl` class is an implementation of the
/// `OnBoardingLocalDataSource` interface that provides actual functionality
/// for storing and retrieving onboarding-related data locally using
/// `SharedPreferences`. It encapsulates the logic for working with local storage
/// and promotes clean separation of concerns in the application's architecture.
class OnBoardingLocalDataSrcImpl extends OnBoardingLocalDataSource {
  /// Constructs an instance of [OnBoardingLocalDataSrcImpl] with the provided
  /// `SharedPreferences` instance [_prefs].
  const OnBoardingLocalDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  /// Caches the information indicating that a user is not a first-time user.
  ///
  /// It sets the value associated with [kFirstTimerKey] to `false`, indicating
  /// that the user is not a first-time user.
  ///
  /// Throws a [CacheException] with an error message if any errors occur during
  /// the caching process.
  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  /// Checks if a user is a first-time user by retrieving the value associated
  /// with [kFirstTimerKey] from `SharedPreferences`.
  ///
  /// If the key is not found, it defaults to `true`, indicating that the user
  /// is a first-time user.
  ///
  /// Throws a [CacheException] with an error message if any errors occur during
  /// the retrieval process.
  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
