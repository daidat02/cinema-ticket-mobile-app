class Showtime {
  final String id;
  final DateTime startTime;
  final int? seatNumbers;
  final int? availableSeats;

  Showtime(
      {required this.id,
      required this.startTime,
      this.seatNumbers,
      this.availableSeats});

  factory Showtime.fromJson(Map<String, dynamic> json) {
    return Showtime(
        id: json['_id'],
        startTime: DateTime.parse(json['startTime']),
        seatNumbers: json['seatNumbers'],
        availableSeats: json['availableSeats']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'startTime': startTime.toIso8601String(),
    };
  }
}
