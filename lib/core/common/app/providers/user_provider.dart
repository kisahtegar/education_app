import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';

/// This `Provider` used for minus state management, exposing things accross the
/// entire widget tree abstracting state as well. So, then use `bloc` for
/// inter-layer communication.
class UserProvider extends ChangeNotifier {
  LocalUserModel? _user;

  LocalUserModel? get user => _user;

  void initUser(LocalUserModel? user) {
    if (_user != user) _user = user;
  }

  set user(LocalUserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
