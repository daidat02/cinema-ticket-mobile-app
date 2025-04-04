import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/User.dart';

class Storage {
  static Future<void> savedUser(
      accessToken, refreshToken, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('user', jsonEncode(user));
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      Map<String, dynamic> jsonData = jsonDecode(userData);
      return User.fromJson(jsonData);
    }
    return null;
  }

  static Future<bool> isMovieFavorite(String movieId) async {
    final user = await getUser();

    return user?.moviesFavourite?.contains(movieId) ?? false;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('user');
  }
}
