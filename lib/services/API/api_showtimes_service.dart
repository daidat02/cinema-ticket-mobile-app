import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:shop/models/CinemaShowtime.dart';

class ShowtimesService {
  Future<List<CinemaShowtimes>> loadCinemaShowtimes(movieId, date) async {
    final url =
        Uri.parse('http://10.0.2.2:3000/api/showtime/movie/$movieId/$date');

    final response = await http.get(url);
    final data = json.decode(response.body);

    return (data['data'] as List)
        .map((e) => CinemaShowtimes.fromJson(e))
        .toList();
  }
}
