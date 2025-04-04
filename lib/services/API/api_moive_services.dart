import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:shop/models/MovieModel.dart';

class MovieService {
  Future<List<Movie>> loadMoviesApi() async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/movie/');
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      return (data['data'] as List).map((e) => Movie.fromJson(e)).toList();
    } catch (error) {
      print('Lỗi kết nối: $error');
      return []; // Trả về danh sách rỗng khi có lỗi
    }
  }

  Future<List<Movie>> loadMoviesFavouriteApi(accessToken) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/movie/add-movie-favourite/');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Token': "Bearer $accessToken"
      });
      final data = json.decode(response.body);

      return (data['data'] as List).map((e) => Movie.fromJson(e)).toList();
    } catch (error) {
      print('Lỗi kết nối: $error');
      return []; // Trả về danh sách rỗng khi có lỗi
    }
  }

  Future<Map<String, dynamic>> updateMovieFavouriteApi(
      accessToken, String movieId) async {
    final url = Uri.parse(
        'https://mbooking-server-production.up.railway.app/api/movie/update-movie-favourite/$movieId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token':
              "Bearer $accessToken" // Thường dùng 'Authorization' thay vì 'Token'
        },
      );
      return jsonDecode(response.body);
    } catch (error) {
      print('Lỗi kết nối: $error');
      return {
        'success': false,
        'error': error.toString(),
        'statusCode': 500,
      };
    }
  }
}
