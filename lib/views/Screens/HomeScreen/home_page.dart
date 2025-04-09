import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_header_widget.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_title_widget.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/main_app_bar.dart';
import 'package:shop/views/Widgets/search_widget.dart';
import 'package:shop/views/Widgets/top_movie_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  int _currentIndex = 0;
  List<Movie> movies = [];
  List<Movie> nowShowingMovies = [];
  List<Movie> comingSoonMovies = [];
  final MovieService _movieService = MovieService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUser();
    loadMovies();
  }

  Future<void> fetchUser() async {
    User? userData = await Storage.getUser();
    setState(() {
      user = userData;
    });
  }

  Future<void> loadMovies() async {
    try {
      LoadingOverlay.show(context);
      List<Movie> loadedMovies = await _movieService.loadMoviesApi();
      setState(() {
        movies = loadedMovies;
        // Lọc phim đang chiếu (ngày phát hành <= ngày hiện tại)
        nowShowingMovies = loadedMovies.where((movie) {
          final releaseDate = DateTime.parse('${movie.releaseDate}' ?? '');
          return releaseDate.isBefore(DateTime.now()) ||
              releaseDate.isAtSameMomentAs(DateTime.now());
        }).toList();
        // Lọc phim sắp chiếu (ngày phát hành > ngày hiện tại)
        comingSoonMovies = loadedMovies.where((movie) {
          final releaseDate = DateTime.parse('${movie.releaseDate}' ?? '');
          return releaseDate.isAfter(DateTime.now());
        }).toList();
      });
      await Future.delayed(const Duration(seconds: 2));
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return MainAppBar(user: authProvider.user);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 60),
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/search',
                      arguments: movies),
                  child: const SearchWidget()),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset('assets/images/slide.png')),
              const SizedBox(height: 20),

              // Top movies
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: sectionTitleWidget('Phim Nổi Bật')),
              SizedBox(
                height: 410,
                child: FlutterCarousel(
                  items: movies
                      .map((movie) => TopMovieCard(movie: movie))
                      .toList(),
                  options: CarouselOptions(
                    height: 500,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    showIndicator: false,
                  ),
                ),
              ),
              LineWidget(),
              const SizedBox(height: 10),

              sectionHeader('Phim Đang Chiếu', 'Xem tất cả', 0xFF007AFF,
                  '/list_movie', true),
              SizedBox(
                height: 340,
                child: _buildListMovie(nowShowingMovies),
              ),

              LineWidget(),
              const SizedBox(height: 10),

              sectionHeader('Phim Sắp Chiếu', 'Xem tất cả', 0xFF007AFF,
                  '/list_movie', false),
              SizedBox(
                height: 340,
                child: _buildListMovie(comingSoonMovies),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildListMovie(List<Movie> movies) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(right: 10),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 180,
          height: 270,
          child: TopMovieCard(movie: movies[index]),
        );
      },
    );
  }
}
