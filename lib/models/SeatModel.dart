class Seat {
  String? sId;
  String? seatNumber;
  String? seatType;
  int? price;
  String? room;
  int? iV;

  Seat({
    this.sId,
    this.seatNumber,
    this.seatType,
    this.price,
    this.room,
    this.iV,
  });

  Seat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    seatNumber = json['seatNumber'];
    seatType = json['seatType'] ?? ''; // Giá trị mặc định
    price = json['price'] ?? 0; // Giá trị mặc định
    room = json['room'] ?? ''; // Giá trị mặc định
    iV = json['__v'] ?? 0; // Giá trị mặc định
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'seatNumber': seatNumber,
      if (seatType != null) 'seatType': seatType,
      if (price != null) 'price': price,
      if (room != null) 'room': room,
      if (iV != null) '__v': iV,
    };
  }
}
