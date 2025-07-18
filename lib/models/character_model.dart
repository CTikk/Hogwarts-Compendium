class Character {
  final String id;
  final String name;
  final String species;
  final String gender;
  final String house;
  final String patronus;
  final String imageURL;

  Character({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.house,
    required this.patronus,
    required this.imageURL
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final attr = json['attributes'];
    return Character(
      id: json['id'],
      name: attr['name'] ?? 'No disponible',
      species: attr['species'] ?? 'No disponible',
      gender: attr['gender'] ?? 'No disponible',
      house: attr['house'] ?? 'No disponible',
      patronus: attr['patronus'] ?? 'No disponible',
      imageURL: attr['image'] ?? '',
    );
  }
}