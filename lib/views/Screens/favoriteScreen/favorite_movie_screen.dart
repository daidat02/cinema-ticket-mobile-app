import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/providers/movieProvider.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  Future<void> _loadFavoriteMovies() async {
    try {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      await movieProvider.loadFavorites();
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi tải danh sách phim';
      });
      print('Error loading favorite movies: $e');
      LoadingOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBarWidget(
        title: 'Phim Yêu Thích',
        showBackButton: false,
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (_errorMessage != null) {
            return _buildErrorState();
          }
          if (movieProvider.favoriteMovies == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (movieProvider.favoriteMovies!.isEmpty) {
            return _buildEmptyState();
          }
          return Container(
              child: _buildMoviesGrid(movieProvider.favoriteMovies!));
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            _errorMessage!,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadFavoriteMovies,
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const Text(
            'Bạn chưa có phim yêu thích',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn vào biểu tượng trái tim để thêm phim',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesGrid(List<Movie> movies) {
    return RefreshIndicator(
      onRefresh: _loadFavoriteMovies,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          childAspectRatio: 0.60,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return FavouriteMovieCard(movie: movies[index]);
        },
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: PosterWidget(
                imageUrl: movie.imageUrl ?? '',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title ?? 'Không có tên',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class FavouriteMovieCard extends StatelessWidget {
  final Movie movie;

  const FavouriteMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_movie', arguments: movie);
      },
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Poster với overlay ngày chiếu
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  child: PosterWidget(
                    imageUrl: movie.imageUrl ?? 'N/A',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            // Tên phim
            Text(
              movie.title ?? 'N/A',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),

            Text(
              movie.genre ?? 'N/A',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 144, 144, 144),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
