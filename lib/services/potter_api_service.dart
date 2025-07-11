import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';

class PotterApiService {
  final String baseUrl = 'https://api.potterdb.com/v1';

  Future<List<Character>> fetchCharacters({String? nameFilter, String? houseFilter}) async {
    final uri = Uri.parse('$baseUrl/characters');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      var characters = data.map((item) => Character.fromJson(item)).toList();
      if (nameFilter != null && nameFilter.isNotEmpty) {
        characters = characters
            .where((c) => c.name.toLowerCase().contains(nameFilter.toLowerCase()))
            .toList();
      }
      if (houseFilter != null && houseFilter.isNotEmpty) {
        characters = characters
            .where((c) => c.house.toLowerCase() == houseFilter.toLowerCase())
            .toList();
      }
      return characters;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<Spell>> fetchSpells({String? typeFilter}) async {
    final response = await http.get(Uri.parse('$baseUrl/spells'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      var spells = data.map((item) => Spell.fromJson(item)).toList();
      if (typeFilter != null && typeFilter.isNotEmpty) {
        spells = spells.where((s) => s.type.toLowerCase().contains(typeFilter.toLowerCase())).toList();
      }
      return spells;
    } else {
      throw Exception('Failed to load spells');
    }
  }

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movies'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data'];
      return data.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Character>> getFeaturedCharacters(String house) async {
    final characters = await fetchCharacters(houseFilter: house);
    characters.shuffle();
    return characters.take(3).toList();
  }

  Future<List<Spell>> getFeaturedSpells() async {
    final spells = await fetchSpells();
    spells.shuffle();
    return spells.take(3).toList();
  }
} 
