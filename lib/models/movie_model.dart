class Movie {
  final String id;
  final String title;
  final String releaseDate;
  final String director;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.director,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Movie(
      id: json['id'],
      title: attr['title'] ?? '',
      releaseDate: attr['release_date'] ?? '',
      director: attr['director'] ?? '',
    );
  }
}