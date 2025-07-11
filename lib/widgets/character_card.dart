import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../pages/detail_page.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.house.isNotEmpty ? character.house : 'Sin casa'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: character.name,
                details: {
                  'Especie': character.species,
                  'Género': character.gender,
                  'Casa': character.house,
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
