import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiPaymentService {
  Future<Map<String, dynamic>> bookTicket(
      Map<String, dynamic> bookData, accessToken) async {
    final url = Uri.parse('http://10.0.2.2:3000/api/payment/book-ticket');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'token': "Bearer $accessToken" // ✅ Thêm header JSON
          },
          body: jsonEncode(bookData));

      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return data;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}
