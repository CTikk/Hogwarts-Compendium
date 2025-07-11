class Book {
  final String id;
  final String title;
  final String releaseDate;
  final int pages;
  final String imageURL;

  Book({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.pages,
    required this.imageURL
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Book(
      id: json['id'],
      title: attr['title'] ?? '',
      releaseDate: attr['release_date'] ?? '',
      pages: attr['pages'] ?? 0,
      imageURL: attr['image'] ?? ''
    );
  }
}