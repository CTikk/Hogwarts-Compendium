class Movie {
  final String id;
  final String title;
  final String releaseDate;
  final String director;
  final String imageURL;
  final String summary;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.director,
    required this.imageURL,
    required this.summary
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Movie(
      id: json['id'],
      title: attr['title'] ?? '',
      releaseDate: attr['release_date'] ?? '',
      director: (attr['directors'] as List<dynamic>?)?.join(', ') ?? '',
      imageURL: attr['poster'] ?? '',
      summary: attr['summary'] ?? ''
    );
  }
}