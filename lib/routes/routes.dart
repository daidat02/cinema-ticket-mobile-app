import 'package:flutter/material.dart';
import 'package:shop/models/Movie.dart';
import 'package:shop/views/Screens/HomeScreen/home_page.dart';
import 'package:shop/views/Screens/ListMovieScreen/list_movie_screen.dart';
import 'package:shop/views/Screens/MovieScreen/detail_movie.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    case '/detail_movie':
      final movie = settings.arguments as Movie;
      return MaterialPageRoute(builder: (context) => DetailMovie(movie: movie));

    case '/list_movie':
      // final movies = settings.arguments as Movie;
      return MaterialPageRoute(builder: (context) => const ListMovieScreen());
    default:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
  }
}
