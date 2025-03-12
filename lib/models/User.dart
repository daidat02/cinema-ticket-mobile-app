class User {
  final String sId;
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int ticketsBooked;
  final int totalReviews;
  final int moviesWatched;

  User({
    required this.sId,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.ticketsBooked,
    required this.totalReviews,
    required this.moviesWatched,
  });

  // Chuyển JSON thành model User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json['_id'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      ticketsBooked: json['ticketsBooked'] ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
      moviesWatched: json['moviesWatched'] ?? 0,
    );
  }

  // Chuyển model User thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'ticketsBooked': ticketsBooked,
      'totalReviews': totalReviews,
      'moviesWatched': moviesWatched,
    };
  }
}
