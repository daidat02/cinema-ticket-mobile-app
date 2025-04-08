import 'package:shop/models/ShowtimeModel.dart';

class MovieShowtime {
  String? sId;
  String? movieName;
  String? movieImage;
  int? movieDuration;
  String? movieGenre;
  List<Showtime>? showtimes;

  MovieShowtime(
      {this.sId,
      this.movieName,
      this.movieImage,
      this.movieDuration,
      this.movieGenre,
      this.showtimes});

  MovieShowtime.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    movieName = json['movieName'];
    movieImage = json['movieImage'];
    movieDuration = json['movieDuration'];
    movieGenre = json['movieGenre'];
    if (json['showtimes'] != null) {
      showtimes = <Showtime>[];
      json['showtimes'].forEach((v) {
        showtimes!.add(Showtime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['movieName'] = movieName;
    data['movieImage'] = movieImage;
    data['movieDuration'] = movieDuration;
    data['movieGenre'] = movieGenre;
    if (showtimes != null) {
      data['showtimes'] = showtimes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
