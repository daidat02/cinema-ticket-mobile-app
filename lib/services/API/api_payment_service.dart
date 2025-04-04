import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiPaymentService {
  Future<Map<String, dynamic>> bookTicket(
      Map<String, dynamic> bookData, accessToken) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/payment/book-ticket');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'token': "Bearer $accessToken" // ✅ Thêm header JSON
          },
          body: jsonEncode({
            'showtimeId': bookData['showtimeId'],
            'seats': bookData['seats'],
          }));

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        print(data['ticket']['id']);
        return data;
      } else {
        throw (data['message']);
      }
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> createVnPayUrl(
      String ticketId, accessToken) async {
    final url = Uri.parse(
        "https://mbooking-server-production.up.railway.app/api/payment/create-url-vnp/?ticketId=$ticketId");
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Token': "Bearer $accessToken"
      });
      final data = jsonDecode(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> vnPayReturn(String vnpParams) async {
    final url = Uri.parse(
        "https://mbooking-server-production.up.railway.app/api/payment/vnp-return/?$vnpParams");
    try {
      final response = await http.get(url);

      return jsonDecode(response.body);
    } catch (e) {
      return throw Exception(e);
    }
  }
}
