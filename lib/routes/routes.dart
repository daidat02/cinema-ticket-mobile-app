import 'package:flutter/material.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/ShowtimeModel.dart';
import 'package:shop/views/Screens/HomeScreen/home_page.dart';
import 'package:shop/views/Screens/ListMovieScreen/list_movie_screen.dart';
import 'package:shop/views/Screens/MovieScreen/detail_movie.dart';
import 'package:shop/views/Screens/SeatSelectionScreen/seat_selection_screen.dart';
import 'package:shop/views/Screens/ShowtimeScreen/showtime_Screen.dart';

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
    case '/showtime':
      final movie = settings.arguments as Movie;
      return MaterialPageRoute(
          builder: (context) => ShowtimeScreen(movie: movie));
    case '/seat_selection':
      final String showtimeId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => SeatSelectionScreen(showtimeId: showtimeId));
    default:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
  }
}
