import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/potter_api_service.dart';
import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';
import '../provider/user_preferences_provider.dart';
import '../widgets/character_card.dart';
import '../widgets/spell_card.dart';
import '../widgets/book_card.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/search_bar.dart' as custom;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PotterApiService _apiService = PotterApiService();
  String searchQuery = '';
  bool isSearching = false;
  List<Character> foundCharacters = [];
  List<Spell> foundSpells = [];
  List<Book> foundBooks = [];
  List<Movie> foundMovies = [];

  void _onSearchChanged(String query) async {
    setState(() {
      searchQuery = query;
      isSearching = true;
    });

    final prefs = Provider.of<UserPreferencesProvider>(context, listen: false);

    final characters = await _apiService.fetchCharacters(nameFilter: query, houseFilter: prefs.house);
    final spells = await _apiService.fetchSpells(typeFilter: query);
    final books = (await _apiService.fetchBooks())
        .where((b) => b.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final movies = (await _apiService.fetchMovies())
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      foundCharacters = characters;
      foundSpells = spells;
      foundBooks = books;
      foundMovies = movies;
      isSearching = false;
    });
  }

  Widget _buildSearchResults() {
    return ListView(
      children: [
        if (foundCharacters.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Personajes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...foundCharacters.map((c) => CharacterCard(character: c)),
        ],
        if (foundSpells.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Hechizos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...foundSpells.map((s) => SpellCard(spell: s)),
        ],
        if (foundBooks.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Libros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...foundBooks.map((b) => BookCard(book: b)),
        ],
        if (foundMovies.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Películas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...foundMovies.map((m) => MovieCard(movie: m)),
        ],
        if (foundCharacters.isEmpty &&
            foundSpells.isEmpty &&
            foundBooks.isEmpty &&
            foundMovies.isEmpty)
          const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No se encontraron resultados.'),
          )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: custom.SearchBar(
              hintText: 'Buscar personaje, hechizo, libro o película...',
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: searchQuery.isEmpty
                ? const Center(child: Text('Usa la barra de búsqueda para comenzar.'))
                : isSearching
                    ? const LoadingIndicator()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }
}
