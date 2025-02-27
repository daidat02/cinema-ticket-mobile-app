class Showtime {
  final String id;
  final DateTime startTime;

  Showtime({required this.id, required this.startTime});

  factory Showtime.fromJson(Map<String, dynamic> json) {
    return Showtime(
        id: json['_id'], startTime: DateTime.parse(json['startTime']));
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'startTime': startTime.toIso8601String(),
    };
  }
}
