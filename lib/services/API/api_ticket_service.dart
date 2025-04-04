import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop/models/TicketModel.dart';

class ApiTicketService {
  Future<List<Ticket>> getTicketsByUserId(String accessToken) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/ticket/ticket/');

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
