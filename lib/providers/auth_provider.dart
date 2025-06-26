import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:operationsports/utils/shared_prefs.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';
  String _token = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;
  String get token => _token;

  AuthProvider() {
    _loadStoredAuthData();
  }

  Future<void> _loadStoredAuthData() async {
    final storedToken = await SharedPrefs.getToken();
    final storedUsername = await SharedPrefs.getUsername();
    final storedAuthState = await SharedPrefs.getAuthenticationState();

    if (storedToken != null && storedUsername != null && storedAuthState) {
      _token = storedToken;
      _username = storedUsername;
      _isAuthenticated = storedAuthState;
      notifyListeners();
    }
  }

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
      
      // Save to persistent storage
      await SharedPrefs.saveToken(_token);
      await SharedPrefs.saveUsername(_username);
      await SharedPrefs.saveAuthenticationState(_isAuthenticated);
      
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signup(String username, String email, String password) async {
    // TODO: Replace this with real signup logic using WP REST API
    _isAuthenticated = true;
    _username = username;
    
    // Save to persistent storage
    await SharedPrefs.saveUsername(_username);
    await SharedPrefs.saveAuthenticationState(_isAuthenticated);
    
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _username = '';
    _token = '';
    
    // Clear persistent storage
    await SharedPrefs.clearAuthData();
    
    notifyListeners();
  }

  // Method to update token (useful when token is refreshed)
  Future<void> updateToken(String newToken) async {
    _token = newToken;
    await SharedPrefs.saveToken(_token);
    notifyListeners();
  }
}
