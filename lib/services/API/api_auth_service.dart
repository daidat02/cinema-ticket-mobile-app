import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop/models/User.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/services/stores.dart';

class ApiAuthService {
  Future<Map<String, dynamic>> register(
      Map<String, dynamic> registerData) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/auth/register');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json', // ✅ Thêm header JSON
          },
          body: jsonEncode(registerData));

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        return data;
      } else {
        return data;
      }
    } catch (e) {
      print(e);
      throw Exception('$e');
    }
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> userData) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/auth/login');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json', // ✅ Thêm header JSON
          },
          body: jsonEncode(userData));
      final data = jsonDecode(response.body);
      if (data['code'] == 200) {
        // Đăng nhập thành công
        await Storage.savedUser(
            data['accessToken'], data['refreshToken'], data['user']);

        return data;
      } else {
        // Đăng nhập thất bại, trả về lỗi từ server
        throw (data['message'] ?? 'Lỗi không xác định');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<User> getUser() async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/auth/user');
    try {
      final response = await http.get(url, headers: {
        'token': 'Bearer ${await Storage.getAccessToken()}',
      });

      final user = jsonDecode(response.body);
      print(user);
      return User.fromJson(user['data']);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
