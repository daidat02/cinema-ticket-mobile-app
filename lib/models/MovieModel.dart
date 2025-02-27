class Movie {
  String? sId;
  String? id;
  String? title;
  int? duration;
  String? genre;
  String? description;
  String? director;
  String? actor;
  DateTime? releaseDate;
  String? imageUrl;
  int? iV;

  Movie(
      {this.sId,
      this.id,
      this.title,
      this.duration,
      this.genre,
      this.description,
      this.director,
      this.actor,
      this.releaseDate,
      this.imageUrl,
      this.iV});

  Movie.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    genre = json['genre'];
    description = json['description'];
    director = json['director'];
    actor = json['actor'];
    releaseDate = DateTime.parse(json['releaseDate']);
    imageUrl = json['imageUrl'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['title'] = title;
    data['duration'] = duration;
    data['genre'] = genre;
    data['description'] = description;
    data['director'] = director;
    data['actor'] = actor;
    data['releaseDate'] = releaseDate;
    data['imageUrl'] = imageUrl;
    data['__v'] = iV;
    return data;
  }
}
