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
      name: attr['name'] ?? 'Unknown',
      species: attr['species'] ?? '',
      gender: attr['gender'] ?? '',
      house: attr['house'] ?? '',
      patronus: attr['patronus'] ?? '',
      imageURL: attr['image'] ?? '',
    );
  }
}