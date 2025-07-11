import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../services/potter_api_service.dart';
import '../widgets/character_card.dart';
import '../widgets/spell_card.dart';

class FeaturedSection extends StatelessWidget {
  final String title;
  final Future<List<dynamic>> futureItems;

  const FeaturedSection({super.key, required this.title, required this.futureItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        FutureBuilder<List<dynamic>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No hay elementos destacados');
            }

            return Column(
              children: snapshot.data!.map((item) {
                if (item is Character) {
                  return CharacterCard(character: item);
                } else if (item is Spell) {
                  return SpellCard(spell: item);
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}