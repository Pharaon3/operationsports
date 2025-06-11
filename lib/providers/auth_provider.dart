import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';
  String _token = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;
  String get token => _token;

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://forums.operationsports.com/forums/auth/ajax-login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    final data = json.decode(response.body);

    if (data['success'] == true) {
      _isAuthenticated = true;
      _username = username;
      _token = data['newtoken'];
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
    _token = '';
    notifyListeners();
  }
}
