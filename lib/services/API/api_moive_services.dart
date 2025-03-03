import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shop/models/MovieModel.dart';

class MovieService {
  Future<List<Movie>> loadMoviesApi() async {
    final url = Uri.parse('http://10.0.2.2:3000/api/movie/');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      return (data['data'] as List).map((e) => Movie.fromJson(e)).toList();
    } catch (error) {
      print('Lỗi kết nối: $error');
      return []; // Trả về danh sách rỗng khi có lỗi
    }
  }
}
