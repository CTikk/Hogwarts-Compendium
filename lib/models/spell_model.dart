class Spell {
  final String id;
  final String name;
  final String incantation;
  final String effect;
  final String type;

  Spell({
    required this.id,
    required this.name,
    required this.incantation,
    required this.effect,
    required this.type,
  });

  factory Spell.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Spell(
      id: json['id'],
      name: attr['name'] ?? '',
      incantation: attr['incantation'] ?? '',
      effect: attr['effect'] ?? '',
      type: attr['type'] ?? '',
    );
  }
}