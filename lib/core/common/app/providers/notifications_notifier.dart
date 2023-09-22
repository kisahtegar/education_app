// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Notifier class to manage notification sound preferences.
class NotificationsNotifier extends ChangeNotifier {
  /// Constructor that initializes the notifier with SharedPreferences.
  NotificationsNotifier(this._prefs) {
    _muteNotifications = _prefs.getBool(key) ?? false;
  }

  /// A constant key used for storing notification preferences in SharedPreferences.
  static const key = 'muteNotifications';

  /// Instance of SharedPreferences to store notification preferences.
  final SharedPreferences _prefs;

  /// A property to track whether notifications are muted (true) or enabled (false).
  late bool _muteNotifications;

  // Getter method to retrieve the current notification mute state.
  bool get muteNotifications => _muteNotifications;

  /// Method to enable notification sounds.
  void enableNotificationSounds() {
    // Set '_muteNotifications' to 'false' (notification sounds enabled).
    _muteNotifications = false;

    // Update the stored preference accordingly.
    _prefs.setBool(key, false);

    // Notify any listeners that the state has changed.
    notifyListeners();
  }

  /// Method to disable notification sounds.
  void disableNotificationSounds() {
    // Set '_muteNotifications' to 'true' (notification sounds disabled).
    _muteNotifications = true;

    // Update the stored preference accordingly.
    _prefs.setBool(key, true);

    // Notify any listeners that the state has changed.
    notifyListeners();
  }

  /// Method to toggle (switch between enabling and disabling) notification sounds.
  void toggleMuteNotifications() {
    // Toggle the '_muteNotifications' state.
    _muteNotifications = !_muteNotifications;

    // Update the stored preference accordingly.
    _prefs.setBool(key, _muteNotifications);

    // Notify any listeners that the state has changed.
    notifyListeners();
  }
}
