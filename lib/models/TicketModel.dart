import 'package:shop/models/CinemaModel.dart';
import 'package:shop/models/DetailShowtime.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/RoomModel.dart';
import 'package:shop/models/SeatModel.dart';

class Ticket {
  String? sId;
  String? id;
  String? user;

  DetailShowtime? showtime;
  List<Seat>? seats;
  int? totalPrice;
  String? status;
  String? bookedAt;
  int? _iV;

  Ticket({
    this.sId,
    this.id,
    this.user,
    this.showtime,
    this.seats,
    this.totalPrice,
    this.status,
    this.bookedAt,
    int? iV,
  }) : _iV = iV;

  Ticket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    user = json['user'];
    showtime = json['showtime'] != null
        ? DetailShowtime.fromJson(json['showtime'])
        : null;

    if (json['seats'] != null) {
      seats = <Seat>[];
      json['seats'].forEach((s) {
        seats!.add(Seat.fromJson(s));
      });
    }

    totalPrice = json['totalPrice'];
    status = json['status'];
    bookedAt = json['bookedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['user'] = user;
    if (showtime != null) {
      data['showtime'] = showtime!.toJson();
    }
    if (seats != null) {
      data['seats'] = seats!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    data['bookedAt'] = bookedAt;
    data['__v'] = _iV;
    return data;
  }
}
