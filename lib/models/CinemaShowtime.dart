import 'package:shop/models/ShowtimeModel.dart';

class CinemaShowtimes {
  final String cinemaName;
  final List<Showtime> showtimes;

  CinemaShowtimes({required this.cinemaName, required this.showtimes});

  factory CinemaShowtimes.fromJson(Map<String, dynamic> json) {
    return CinemaShowtimes(
      cinemaName: json['cinemaName'],
      showtimes: (json['showtimes'] as List) // Chuyển đổi đúng kiểu
          .map((e) => Showtime.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cinemaName': cinemaName,
      'showtimes': showtimes.map((s) => s.toJson()).toList(),
    };
  }
}
