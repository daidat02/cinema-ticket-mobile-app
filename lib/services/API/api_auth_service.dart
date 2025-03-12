import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shop/services/stores.dart';

class ApiAuthService {
  Future<Map<String, dynamic>> login(Map<String, dynamic> userData) async {
    final url = Uri.parse('http://10.0.2.2:3000/api/auth/login');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json', // ✅ Thêm header JSON
          },
          body: jsonEncode(userData));
      final data = jsonDecode(response.body);
      print(jsonEncode(userData));
      if (data['code'] == 200) {
        // Đăng nhập thành công
        print(data['accessToken']);
        await Storage.savedUser(data['accessToken'], data['user']);
        return data;
      } else {
        // Đăng nhập thất bại, trả về lỗi từ server
        throw (data['message'] ?? 'Lỗi không xác định');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
