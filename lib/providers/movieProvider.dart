import 'package:flutter/material.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/services/stores.dart';

class MovieProvider extends ChangeNotifier {
  final MovieService _movieService;
  final AuthProvider _authProvider;

  List<String>? _favoriteMovieIds;
  List<Movie>? _favoriteMovies;

  // Sửa constructor để nhận dependencies từ bên ngoài
  MovieProvider({
    required MovieService movieService,
    required AuthProvider authProvider,
    List<String>? favoriteMovieIds,
  })  : _movieService = movieService,
        _authProvider = authProvider,
        _favoriteMovieIds = favoriteMovieIds;

  // Getter
  List<String>? get favoriteMovieIds => _favoriteMovieIds;
  List<Movie>? get favoriteMovies => _favoriteMovies;

  // Setter
  set favoriteMovieIds(List<String>? ids) {
    _favoriteMovieIds = ids;
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    try {
      final accessToken = await Storage.getAccessToken();
      _favoriteMovies = await _movieService.loadMoviesFavouriteApi(accessToken);
      print('cập nhật thành công');
    } catch (e) {
      debugPrint('Lỗi load favorites: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<bool> isMovieFavorite(String movieId) async {
    return _favoriteMovieIds?.contains(movieId) ?? false;
  }

  Future<String> toggleFavorite(String movieId) async {
    try {
      final accessToken = await Storage.getAccessToken();
      final response =
          await _movieService.updateMovieFavouriteApi(accessToken, movieId);

      if (response['success'] == true) {
        _favoriteMovieIds = List<String>.from(response['data']);
        _authProvider.updateFavoriteMovies(_favoriteMovieIds ?? []);
        await loadFavorites(); // Load lại danh sách
        return response['message'];
      } else {
        throw Exception(response['message'] ?? 'Failed to update favorites');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initializeFavorites() async {
    try {
      await loadFavorites();
    } catch (e) {
      throw Exception('Error initializing favorites: $e');
    }
  }
}
