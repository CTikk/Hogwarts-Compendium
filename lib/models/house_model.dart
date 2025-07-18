class House {
  final String id;
  final String name;
  final String founder;
  final List<String> traits;

  House({
    required this.id,
    required this.name,
    required this.founder,
    required this.traits,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return House(
      id: json['id'],
      name: attr['name'] ?? 'No disponible',
      founder: attr['founder'] ?? 'No disponible',
      traits: List<String>.from(attr['traits'] ?? []),
    );
  }
}