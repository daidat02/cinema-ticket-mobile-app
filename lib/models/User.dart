class User {
  final String sId;
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int ticketsBooked;
  final int totalReviews;
  final int moviesWatched;
  final List<String>? moviesFavourite;
  User(
      {required this.sId,
      required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.ticketsBooked,
      required this.totalReviews,
      required this.moviesWatched,
      this.moviesFavourite});

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
      moviesFavourite: (json['moviesFavourite'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  User copyWith({
    String? sId,
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    int? ticketsBooked,
    int? totalReviews,
    int? moviesWatched,
    List<String>? moviesFavourite,
  }) {
    return User(
      sId: sId ?? this.sId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      ticketsBooked: ticketsBooked ?? this.ticketsBooked,
      totalReviews: totalReviews ?? this.totalReviews,
      moviesWatched: moviesWatched ?? this.moviesWatched,
      moviesFavourite: moviesFavourite ?? this.moviesFavourite,
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
      'moviesFavourite': moviesFavourite
    };
  }
}
