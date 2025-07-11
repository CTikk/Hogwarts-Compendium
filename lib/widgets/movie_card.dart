import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../pages/detail_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text('Director: ${movie.director}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: movie.title,
                details: {
                  'imagen': movie.imageURL,
                  'Fecha de estreno': movie.releaseDate,
                  'Directors': movie.director,
                  'Sumario': movie.summary
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
