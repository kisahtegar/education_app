// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// `OnBoardingLocalDataSource` defines a contract that any concrete implementation
/// must adhere to when working with onboarding-related data in application.
/// This abstraction helps maintain code consistency, separation of concerns,
/// and flexibility when dealing with different local storage options.
abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

/// Defined as a constant string with the value `'first_timer'`. This key is used
/// to access and store the first-time user information in the local storage
/// (SharedPreferences).
const kFirstTimerKey = 'first_timer';

/// `OnBoardingLocalDataSrcImpl` is an implementation of the `OnBoardingLocalDataSource`
/// interface that provides actual functionality for storing and retrieving
/// onboarding-related data locally using `SharedPreferences`. It encapsulates
/// the logic for working with local storage and promotes clean separation of
/// concerns in the application's architecture.
class OnBoardingLocalDataSrcImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  /// This method is responsible for caching the information that indicates whether
  /// a user is a first-time user. It uses the provided `SharedPreferences` instance
  /// (`_prefs`) to set the value associated with the `kFirstTimerKey` to `false`,
  /// indicating that the user is not a first-time user. If any errors occur during
  /// the caching process, it throws a `CacheException` with an error message.
  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  /// This method is responsible for checking whether a user is a first-time user
  /// by retrieving the value associated with the `kFirstTimerKey` from
  /// `SharedPreferences`. If the key is not found, it defaults to `true`,
  /// indicating that the user is a first-time user. If any errors occur during
  /// the retrieval process, it also throws a `CacheException` with an error message.
  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
