class Book {
  final String id;
  final String title;
  final String releaseDate;
  final int pages;
  final String imageURL;
  final String summary;

  Book({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.pages,
    required this.imageURL,
    required this.summary
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Book(
      id: json['id'],
      title: attr['title'] ?? 'No disponible',
      releaseDate: attr['release_date'] ?? 'No disponible',
      pages: attr['pages'] ?? 0,
      imageURL: attr['cover'] ?? '',
      summary: attr['summary'] ?? 'No disponible'
    );
  }
}