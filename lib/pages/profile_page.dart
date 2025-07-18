import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';
import '../services/potter_api_service.dart';
import '../pages/about_page.dart';
import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';
import '../widgets/favorite_list_section.dart';
import '../widgets/character_card.dart';
import '../widgets/spell_card.dart';
import '../widgets/book_card.dart';
import '../widgets/movie_card.dart';
import '../widgets/offline_banner.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>> _loadFavorites(UserPreferencesProvider prefs) async {
    final api = PotterApiService();

    final allCharacters = await api.fetchCharacters();
    final allSpells = await api.fetchSpells();
    final allBooks = await api.fetchBooks();
    final allMovies = await api.fetchMovies();

    return {
      'characters': allCharacters.where((c) => prefs.favorites['characters']!.contains(c.id)).toList(),
      'spells': allSpells.where((s) => prefs.favorites['spells']!.contains(s.id)).toList(),
      'books': allBooks.where((b) => prefs.favorites['books']!.contains(b.id)).toList(),
      'movies': allMovies.where((m) => prefs.favorites['movies']!.contains(m.id)).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Hogwarts Credential"), centerTitle: true),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadFavorites(prefs),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final characters = snapshot.data!['characters'] as List<Character>;
          final spells = snapshot.data!['spells'] as List<Spell>;
          final books = snapshot.data!['books'] as List<Book>;
          final movies = snapshot.data!['movies'] as List<Movie>;

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const OfflineBanner(),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final picked = await picker.pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          await prefs.updateProfileImagePath(picked.path);
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: prefs.profileImagePath != null
                            ? FileImage(File(prefs.profileImagePath!))
                            : const AssetImage("assets/user.png") as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Nickname: ${prefs.userName}",
                            style: Theme.of(context).textTheme.bodyMedium),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            final controller = TextEditingController(text: prefs.userName);
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Editar Nickname"),
                                content: TextField(controller: controller),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancelar")),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await prefs.updateUserName(controller.text.trim());
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Guardar")),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Member from ${prefs.house}",
                            style: Theme.of(context).textTheme.titleMedium),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String selectedHouse = prefs.house;
                                return AlertDialog(
                                  title: const Text("Choose a house"),
                                  content: DropdownButton<String>(
                                    isExpanded: true,
                                    value: selectedHouse,
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        selectedHouse = value;
                                      }
                                    },
                                    items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                                        .map((house) => DropdownMenuItem(
                                              value: house,
                                              child: Text(house),
                                            ))
                                        .toList(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await prefs.updateHouse(selectedHouse);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Divider(),

              // Secciones de favoritos
              FavoriteListSection<Character>(
                title: "🧙‍♂️ Favorite Characters",
                items: characters,
                cardBuilder: (c) => CharacterCard(character: c),
              ),
              FavoriteListSection<Spell>(
                title: "✨ Favorite Spells",
                items: spells,
                cardBuilder: (s) => SpellCard(spell: s),
              ),
              FavoriteListSection<Book>(
                title: "📚 Favorite Books",
                items: books,
                cardBuilder: (b) => BookCard(book: b),
              ),
              FavoriteListSection<Movie>(
                title: "🎬 Favorite Movies",
                items: movies,
                cardBuilder: (m) => MovieCard(movie: m),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Acerca de Hogwarts Compendium'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
