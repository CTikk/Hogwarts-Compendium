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
      name: attr['name'] ?? '',
      incantation: attr['incantation'] ?? '',
      effect: attr['effect'] ?? '',
      type: attr['type'] ?? '',
      imageURL: attr['image'] ?? '',
    );
  }
}
