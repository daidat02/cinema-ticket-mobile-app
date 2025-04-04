import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class ListMovieScreen extends StatefulWidget {
  const ListMovieScreen({super.key, this.isReleased, this.titleAppbar});
  final bool? isReleased;
  final String? titleAppbar;

  @override
  State<ListMovieScreen> createState() => _ListMovieScreenState();
}

class _ListMovieScreenState extends State<ListMovieScreen> {
  final MovieService _movieService = MovieService();
  List<Movie> movies = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      LoadingOverlay.show(context);
      await Future.delayed(const Duration(seconds: 1));
      List<Movie> loadedMovies = await _movieService.loadMoviesApi();
      setState(() {
        _applyFilter(loadedMovies);
      });
      LoadingOverlay.hide();
    } catch (e) {
      print('Error loading movies: $e');
      LoadingOverlay.hide();
    }
  }

  void _applyFilter(moviesData) {
    if (widget.isReleased == null) {
      movies = moviesData;
    } else {
      movies = moviesData.where((movie) {
        if (movie.releaseDate == null) return false;
        final isReleased = movie.releaseDate!.isBefore(DateTime.now());
        return isReleased == widget.isReleased;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppBarWidget(title: widget.titleAppbar ?? 'N/A'),
      body: _buildMovieListByType(),
    );
  }

  Widget _buildMovieListByType() {
    if (movies.isEmpty) {
      return const Center(child: Text('Không có phim nào'));
    }

    return widget.isReleased == false
        ? _buildUpcomingMoviesGrid()
        : _buildReleasedMoviesList();
  }

  Widget _buildReleasedMoviesList() {
    return RefreshIndicator(
      onRefresh: loadMovies,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: movies.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color.fromARGB(255, 222, 222, 222),
        ),
        itemBuilder: (context, index) {
          return MovieCardWidget(movie: movies[index]);
        },
      ),
    );
  }

  Widget _buildUpcomingMoviesGrid() {
    return RefreshIndicator(
      onRefresh: loadMovies,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail_movie',
                arguments: movies[index],
              );
            },
            child: UpcomingMovieCard(movie: movies[index]),
          );
        },
      ),
    );
  }
}

class MovieCardWidget extends StatelessWidget {
  final Movie movie;

  const MovieCardWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: PosterWidget(
              imageUrl: movie.imageUrl ?? 'N/A',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_icon.svg',
                      height: 14,
                      width: 14,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '8.5/10 (700 Đánh giá)',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  movie.title ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.genre ?? 'N/A',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${movie.duration} Phút | ' ?? '',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(movie.releaseDate ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _actionButton(
                      context: context,
                      title: 'Chi Tiết',
                      pathName: 'heart_icon.svg',
                      color: 0xff61677D,
                      routeName: '/detail_movie',
                      movie: movie,
                    ),
                    const SizedBox(height: 5),
                    _actionButton(
                      context: context,
                      title: 'Mua Vé',
                      pathName: 'heart_icon.svg',
                      color: 0xff3461FD,
                      routeName: '/showtime',
                      movie: movie,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String title,
    required String pathName,
    required int color,
    required String routeName,
    required Movie movie,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        routeName,
        arguments: movie,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(color: Color(color), width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingMovieCard extends StatelessWidget {
  final Movie movie;

  const UpcomingMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 10,
              ),
              Text(
                DateFormat('dd \'Thg\' MM')
                    .format(movie.releaseDate ?? DateTime.now()),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          const SizedBox(
            height: 5,
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
        ],
      ),
    );
  }
}
