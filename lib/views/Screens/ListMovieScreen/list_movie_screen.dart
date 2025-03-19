import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/services/API/api_moive_services.dart';

class ListMovieScreen extends StatefulWidget {
  const ListMovieScreen({
    super.key,
  });

  @override
  State<ListMovieScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListMovieScreen> {
  final MovieService _movieService = MovieService();
  List<Movie> movies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMovies();
  }

  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    print(index);
  }

  Future<void> loadMovies() async {
    List<Movie> loadedMovies = await _movieService.loadMoviesApi();

    setState(() {
      movies = loadedMovies;
    });
    for (var movie in loadedMovies) {
      print(movie.releaseDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('ListMovie'),
      ),
    );
  }
}
