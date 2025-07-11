import 'package:flutter/material.dart';
import '../models/spell_model.dart';
import '../pages/detail_page.dart';

class SpellCard extends StatelessWidget {
  final Spell spell;

  const SpellCard({super.key, required this.spell});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(spell.name),
        subtitle: Text(spell.type),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(
                title: spell.name,
                details: {
                  'imagen': spell.imageURL,
                  'Encantamiento': spell.incantation,
                  'Efecto': spell.effect,
                  'Tipo': spell.type,
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
