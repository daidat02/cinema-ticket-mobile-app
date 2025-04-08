class Cinema {
  final String id;
  final String name;
  final String? location;
  final String? imageUrl;
  bool isFavorite;

  Cinema({
    required this.id,
    required this.name,
    this.location,
    this.imageUrl,
    this.isFavorite = false,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
    );
  }
}
