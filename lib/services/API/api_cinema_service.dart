import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop/models/CinemaModel.dart';

class ApiCinemaService {
  Future<List<Cinema>> loadCinemasApi() async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/cinema/');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      return (data['cinemas'] as List).map((e) => Cinema.fromJson(e)).toList();
    } catch (error) {
      print('Lỗi kết nối: $error');
      return [];
    }
  }
}
