import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../pages/detail_page.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('Páginas: ${book.pages}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: book.title,
                details: {
                  'imagen': book.imageURL,
                  'Fecha de publicación': book.releaseDate,
                  'Número de páginas': book.pages.toString(),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}