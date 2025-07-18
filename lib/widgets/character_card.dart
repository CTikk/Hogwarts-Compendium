import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character_model.dart';
import '../pages/detail_page.dart';
import '../provider/user_preferences_provider.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    final isFav = prefs.isFavorite('characters', character.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.house.isNotEmpty ? character.house : 'Sin casa'),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.star : Icons.star_border,
            color: isFav ? Colors.amber : Colors.grey,
          ),
          onPressed: () => prefs.toggleFavorite('characters', character.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: character.name,
                details: {
                  'imagen': character.imageURL,
                  'Species': character.species,
                  'Gender': character.gender,
                  'House': character.house,
                  'Patronus': character.patronus
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
