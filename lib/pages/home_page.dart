import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_3/pages/profile_page.dart';
import '../provider/user_preferences_provider.dart';
import '../services/potter_api_service.dart';
import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';
import '../widgets/character_card.dart';
import '../widgets/spell_card.dart';
import '../widgets/book_card.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_message.dart';
import '../widgets/featured_section.dart';
import 'search_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final PotterApiService _apiService = PotterApiService();
  String characterSearch = '';
  String spellSearch = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCharacterTab() {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    return ListView(
      children: [
        FeaturedSection(
          title: 'Destacados de ${prefs.house}',
          futureItems: _apiService.getFeaturedCharacters(prefs.house),
        ),
        FutureBuilder<List<Character>>(
          future: _apiService.fetchCharacters(nameFilter: characterSearch, houseFilter: prefs.house),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            } else if (snapshot.hasError) {
              return ErrorMessage(error: snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay personajes disponibles'));
            }
            return Column(
              children: snapshot.data!.map((c) => CharacterCard(character: c)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSpellTab() {
    return ListView(
      children: [
        FeaturedSection(
          title: 'Hechizos destacados',
          futureItems: PotterApiService().getFeaturedSpells(),
        ),
        FutureBuilder<List<Spell>>(
          future: _apiService.fetchSpells(typeFilter: spellSearch),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            } else if (snapshot.hasError) {
              return ErrorMessage(error: snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay hechizos disponibles'));
            }
            return Column(
              children: snapshot.data!.map((s) => SpellCard(spell: s)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBookTab() {
    return FutureBuilder<List<Book>>(
      future: _apiService.fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          return ErrorMessage(error: snapshot.error.toString());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay libros disponibles'));
        }
        return ListView(
          children: snapshot.data!.map((b) => BookCard(book: b)).toList(),
        );
      },
    );
  }

  Widget _buildMovieTab() {
    return FutureBuilder<List<Movie>>(
      future: _apiService.fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator();
        } else if (snapshot.hasError) {
          return ErrorMessage(error: snapshot.error.toString());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay películas disponibles'));
        }
        return ListView(
          children: snapshot.data!.map((m) => MovieCard(movie: m)).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Personajes'),
            Tab(text: 'Hechizos'),
            Tab(text: 'Libros'),
            Tab(text: 'Películas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCharacterTab(),
          _buildSpellTab(),
          _buildBookTab(),
          _buildMovieTab(),
        ],
      ),
    );
  }
}