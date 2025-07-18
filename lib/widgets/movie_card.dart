import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../pages/detail_page.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    final isFav = prefs.isFavorite('movies', movie.id);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text('Director: ${movie.director}'),
        trailing: IconButton(
        icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : Colors.grey),
        onPressed: () => prefs.toggleFavorite('movies', movie.id),
      ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: movie.title,
                details: {
                  'imagen': movie.imageURL,
                  'Release Date': movie.releaseDate,
                  'Directors': movie.director,
                  'Summary': movie.summary
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
