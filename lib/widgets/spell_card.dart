import 'package:flutter/material.dart';
import '../models/spell_model.dart';
import 'package:provider/provider.dart';
import '../pages/detail_page.dart';
import '../provider/user_preferences_provider.dart';

class SpellCard extends StatelessWidget {
  final Spell spell;

  const SpellCard({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    final isFav = prefs.isFavorite('spells', spell.id);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(spell.name),
        subtitle: Text(spell.type),
        trailing: IconButton(
          icon: Icon(isFav ? Icons.star : Icons.star_border, color: isFav ? Colors.amber : Colors.grey),
          onPressed: () => prefs.toggleFavorite('spells', spell.id),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: spell.name,
                details: {
                  'imagen': spell.imageURL,
                  'Enchantment': spell.incantation,
                  'Effect': spell.effect,
                  'Type': spell.type,
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
