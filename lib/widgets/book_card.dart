import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../pages/detail_page.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    final isFav = prefs.isFavorite('books', book.id);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('Páginas: ${book.pages}'),
        trailing: IconButton(
          icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : Colors.grey),
          onPressed: () => prefs.toggleFavorite('books', book.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: book.title,
                details: {
                  'imagen': book.imageURL,
                  'Publish Date': book.releaseDate,
                  'Number of Pages': book.pages.toString(),
                  'Summary': book.summary
                },
              ),
            ),
          );
        },
      ),
    );
  }
}