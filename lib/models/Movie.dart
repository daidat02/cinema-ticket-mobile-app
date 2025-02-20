class Movie {
  final String id;
  final String imageUrl;
  final String title;
  final String genres;
  final String description;
  final double rating;

  Movie({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.genres,
    required this.description,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      genres: json['genres'],
      description: json['description'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'genres': genres,
      'description': description,
      'rating': rating,
    };
  }
}
// genres thể loại phim
// actors diễn viên
// directors đạo diễn
// duration thời lượng phim
// releaseDate ngày phát hành
// rating đánh giá phim
// description mô tả phim
// imageUrl hình ảnh phim
// title tên phim
// id id phim
//ticketsSold số vé đã bán
