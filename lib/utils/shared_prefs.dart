import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _tokenKey = 'security_token';
  static const String _usernameKey = 'username';
  static const String _isAuthenticatedKey = 'is_authenticated';

  // Token management
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Username management
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<void> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }

  // Authentication state management
  static Future<void> saveAuthenticationState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAuthenticatedKey, isAuthenticated);
  }

  static Future<bool> getAuthenticationState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isAuthenticatedKey) ?? false;
  }

  static Future<void> removeAuthenticationState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isAuthenticatedKey);
  }

  // Clear all auth data
  static Future<void> clearAuthData() async {
    await removeToken();
    await removeUsername();
    await removeAuthenticationState();
  }
}
