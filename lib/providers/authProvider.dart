import 'package:flutter/foundation.dart';
import 'package:shop/models/User.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  AuthProvider({User? user, String? accessToken}) {
    _user = user;
    _accessToken = accessToken;
  }
  User? get user => _user;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  // Cập nhật thông tin người dùng và token sau khi đăng nhập thành công
  void setUser(User user, String accessToken, String refreshToken) {
    _user = user;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners(); // Thông báo cho các widget lắng nghe để rebuild UI
  }

  void logout() {
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }
}
