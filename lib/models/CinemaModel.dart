class Cinema {
  final String id;
  final String name;
  final String? address;
  final String? imageUrl;

  Cinema({
    required this.id,
    required this.name,
    this.address,
    this.imageUrl,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      imageUrl: json['imageUrl'],
    );
  }
}
