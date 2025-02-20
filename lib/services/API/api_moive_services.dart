import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shop/models/Movie.dart';

class MovieService {
  Future<List<Movie>> loadMovies() async {
    final String response =
        await rootBundle.loadString('assets/files/movies.json');
    final data = json.decode(response);

    return (data['movies'] as List).map((e) => Movie.fromJson(e)).toList();
  }
}
