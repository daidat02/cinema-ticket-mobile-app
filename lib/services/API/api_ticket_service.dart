import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/TicketModel.dart';

class ApiTicketService {
  Future<List<Ticket>> getTicketsByUserId(String accessToken) async {
    final url = Uri.parse('http://10.0.2.2:3000/api/ticket/ticket/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': "Bearer $accessToken" // ✅ Thêm header JSON
        },
      );
      final data = jsonDecode(response.body);

      return (data['data'] as List)
          .map((ticketJson) => Ticket.fromJson(ticketJson))
          .toList();
    } catch (e) {
      return throw e;
    }
  }
}
