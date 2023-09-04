import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

/// The `UserProvider` class is responsible for state management within the app.
/// It abstracts and exposes user-related data and state changes across the
/// entire widget tree. This provider is designed to be used in conjunction with
/// a state management solution, such as a BLoC (Business Logic Component), to
/// facilitate inter-layer communication and data flow.
class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  /// Gets the current user information.
  LocalUserModel? get user => _user;

  /// Initializes the user with the provided data.
  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  /// Sets the user data and triggers a notification to update the UI.
  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;

      // Schedule the notification to update listeners in the next event loop.
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
