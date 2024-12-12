import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isEnabled = false;
  static const String _prefsKey = 'stock_notifications_enabled';

  NotificationProvider() {
    _loadPreferences();
  }

  bool get isEnabled => _isEnabled;

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_prefsKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _isEnabled = !_isEnabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, _isEnabled);
    notifyListeners();
  }
}
