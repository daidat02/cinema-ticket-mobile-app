import 'package:shop/models/CinemaModel.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/RoomModel.dart';
import 'package:shop/models/SeatModel.dart';

class DetailShowtime {
  String? sId;
  Movie? movie;
  Cinema? cinema;
  DateTime? startTime;
  Room? room;
  bool? isShown;
  List<String>? bookedSeat;
  int? iV;

  DetailShowtime(
      {this.sId,
      this.movie,
      this.cinema,
      this.startTime,
      this.room,
      this.isShown,
      this.bookedSeat,
      this.iV});

  DetailShowtime.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
    cinema = json['cinema'] != null ? Cinema.fromJson(json['cinema']) : null;
    startTime = DateTime.parse(json['startTime']);
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    isShown = json['isShown'];
    if (json['bookedSeat'] != null) {
      bookedSeat = List<String>.from(json['bookedSeat']);
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (movie != null) {
      data['movie'] = movie!.toJson();
    }
    data['startTime'] = startTime;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    data['isShown'] = isShown;
    if (bookedSeat != null) {
      data['bookedSeat'] = bookedSeat;
    }
    data['__v'] = iV;
    return data;
  }
}
