import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop/models/DetailShowtime.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/SeatModel.dart';
import 'package:shop/models/ShowtimeModel.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/views/Screens/HomeScreen/home_page.dart';
import 'package:shop/views/Screens/ListMovieScreen/list_movie_screen.dart';
import 'package:shop/views/Screens/MovieScreen/detail_movie.dart';
import 'package:shop/views/Screens/PaymentScreen/payment_screen.dart';
import 'package:shop/views/Screens/PaymentScreen/vnp_screen.dart';
import 'package:shop/views/Screens/PaymentScreen/widgets/payment_success_screen.dart';
import 'package:shop/views/Screens/SeatSelectionScreen/seat_selection_screen.dart';
import 'package:shop/views/Screens/ShowtimeScreen/showtime_Screen.dart';
import 'package:shop/views/Screens/TicketDetailScreen/ticket_detail_screen.dart';
import 'package:shop/views/Screens/TicketDetailScreen/ticket_list_screen.dart';
import 'package:shop/views/Screens/authScreen/login_Screen.dart';
import 'package:shop/views/Screens/authScreen/register_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case '/register':
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case '/detail_movie':
      final movie = settings.arguments as Movie;
      return MaterialPageRoute(builder: (context) => DetailMovie(movie: movie));

    case '/list_movie':
      final args = settings.arguments as Map<String, dynamic>;

      final bool isReleased = args['isReleased'];
      final String titleAppbar = args['titleAppbar'];

      return MaterialPageRoute(
          builder: (context) => ListMovieScreen(
                isReleased: isReleased,
                titleAppbar: titleAppbar,
              ));
    case '/showtime':
      final movie = settings.arguments as Movie;
      return MaterialPageRoute(
          builder: (context) => ShowtimeScreen(movie: movie));
    case '/seat_selection':
      final String showtimeId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => SeatSelectionScreen(showtimeId: showtimeId));
    case '/payment':
      {
        final args = settings.arguments as Map<String, dynamic>;

        final DetailShowtime detailShowtime = args['detailShowtime'];
        final List<Seat> seats = args['selectedSeats'];
        final double totalPriceTicket = args['totalPrice'];

        return MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  detailShowtime: detailShowtime,
                  selectedSeats: seats,
                  totalPriceTicket: totalPriceTicket,
                ));
      }
    case '/payment_success':
      {
        final String ticketId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
                  ticketId: ticketId,
                ));
      }
    case '/ticket-detail':
      {
        final ticket = settings.arguments as Ticket;
        return MaterialPageRoute(
            builder: (context) => TicketDetailScreen(
                  ticket: ticket,
                ));
      }
    case '/list-ticket':
      {
        return MaterialPageRoute(
            builder: (context) => const TicketListScreen());
      }
    case '/vnp-payment':
      {
        final paymentUrl = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => VNPayScreen(
                  paymentUrl: paymentUrl,
                ));
      }
    default:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
  }
}
