import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;

  Future<void> login(String username, String password) async {
    // TODO: Replace this with actual API call to WordPress (via JWT plugin or similar)
    if (username == 'admin' && password == 'password') {
      _isAuthenticated = true;
      _username = username;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signup(String username, String email, String password) async {
    // TODO: Replace this with real signup logic using WP REST API
    _isAuthenticated = true;
    _username = username;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _username = '';
    notifyListeners();
  }
}
