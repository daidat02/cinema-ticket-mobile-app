import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:shop/models/CinemaShowtime.dart';
import 'package:shop/models/DetailShowtime.dart';

class ShowtimesService {
  Future<List<CinemaShowtimes>> loadCinemaShowtimes(movieId, date) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/showtime/movie/$movieId/$date');

    final response = await http.get(url);
    final data = json.decode(response.body);

    return (data['data'] as List)
        .map((e) => CinemaShowtimes.fromJson(e))
        .toList();
  }

  Future<DetailShowtime> loadDetailShowtime(showtimeId) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/showtime/room/$showtimeId');

    final response = await http.get(url);
    if (response.body.isEmpty) {
      throw Exception("API trả về rỗng");
    } else {
      final data = jsonDecode(response.body);
      return DetailShowtime.fromJson(data['data']);
    }
  }
}
