import 'package:shop/models/SeatModel.dart';

class Room {
  String? sId;
  String? name;
  String? cinema;
  String? id;
  List<Seat>? seats;

  Room({this.sId, this.name, this.cinema, this.id, this.seats});

  Room.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    cinema = json['cinema'];
    id = json['id'];
    if (json['seats'] != null) {
      seats = <Seat>[];
      json['seats'].forEach((v) {
        seats!.add(Seat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['cinema'] = cinema;
    data['id'] = id;
    if (seats != null) {
      data['seats'] = seats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
