class Seat {
  String? sId;
  String? seatNumber;
  String? seatType;
  int? price;
  String? room;
  int? iV;

  Seat(
      {this.sId,
      this.seatNumber,
      this.seatType,
      this.price,
      this.room,
      this.iV});

  Seat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    seatNumber = json['seatNumber'];
    seatType = json['seatType'];
    price = json['price'];
    room = json['room'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['seatNumber'] = seatNumber;
    data['seatType'] = seatType;
    data['price'] = price;
    data['room'] = room;
    data['__v'] = iV;
    return data;
  }
}
