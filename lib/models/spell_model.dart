class Spell {
  final String id;
  final String name;
  final String incantation;
  final String effect;
  final String type;
  final String imageURL;

  Spell({
    required this.id,
    required this.name,
    required this.incantation,
    required this.effect,
    required this.type,
    required this.imageURL,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Spell(
      id: json['id'],
      name: attr['name'] ?? 'No disponible',
      incantation: attr['incantation'] ?? 'No disponible',
      effect: attr['effect'] ?? 'No disponible',
      type: attr['type'] ?? 'No disponible',
      imageURL: attr['image'] ?? '',
    );
  }
}
