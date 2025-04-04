import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/User.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  AuthProvider({User? user}) {
    _user = user;
  }

  User? get user => _user;

  // Cập nhật thông tin người dùng và token sau khi đăng nhập thành công
  void setUser(User user) {
    _user = user;
    notifyListeners(); // Thông báo cho các widget lắng nghe để rebuild UI
  }

  void updateFavoriteMovies(List<String> newFavorites) {
    if (_user != null) {
      _user = _user!.copyWith(moviesFavourite: newFavorites);
      _saveUserToStorage();
      notifyListeners();
    }
  }

  Future<void> _saveUserToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(_user?.toJson()));
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
