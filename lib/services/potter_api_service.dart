import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/character_model.dart';
import '../models/spell_model.dart';
import '../models/book_model.dart';
import '../models/movie_model.dart';

class PotterApiService {
  final String baseUrl = 'https://api.potterdb.com/v1';

  // 🔁 Verifica si hay conexión real
  Future<bool> _hasInternet() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // 🧙 Fetch personajes con caché
  Future<List<Character>> fetchCharacters({String? nameFilter, String? houseFilter}) async {
    const cacheKey = 'cached_characters';
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$baseUrl/characters');

    try {
      if (await _hasInternet()) {
        final response = await http.get(uri).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          prefs.setString(cacheKey, response.body);
          return _parseCharacters(response.body, nameFilter, houseFilter);
        } else {
          throw Exception('Error ${response.statusCode}');
        }
      } else {
        final cached = prefs.getString(cacheKey);
        if (cached != null) {
          return _parseCharacters(cached, nameFilter, houseFilter);
        } else {
          throw Exception('Sin internet y sin datos guardados');
        }
      }
    } catch (e) {
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        return _parseCharacters(cached, nameFilter, houseFilter);
      } else {
        throw Exception('Error de red: $e');
      }
    }
  }

  List<Character> _parseCharacters(String jsonStr, String? nameFilter, String? houseFilter) {
    final jsonData = json.decode(jsonStr);
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
  }

  // ✨ Fetch hechizos con caché
  Future<List<Spell>> fetchSpells({String? typeFilter}) async {
    const cacheKey = 'cached_spells';
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$baseUrl/spells');

    try {
      if (await _hasInternet()) {
        final response = await http.get(uri).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          prefs.setString(cacheKey, response.body);
          return _parseSpells(response.body, typeFilter);
        } else {
          throw Exception('Error ${response.statusCode}');
        }
      } else {
        final cached = prefs.getString(cacheKey);
        if (cached != null) {
          return _parseSpells(cached, typeFilter);
        } else {
          throw Exception('Sin internet y sin datos guardados');
        }
      }
    } catch (e) {
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        return _parseSpells(cached, typeFilter);
      } else {
        throw Exception('Error de red: $e');
      }
    }
  }

  List<Spell> _parseSpells(String jsonStr, String? typeFilter) {
    final jsonData = json.decode(jsonStr);
    final List data = jsonData['data'];
    var spells = data.map((item) => Spell.fromJson(item)).toList();

    if (typeFilter != null && typeFilter.isNotEmpty) {
      spells = spells
          .where((s) => s.type.toLowerCase().contains(typeFilter.toLowerCase()))
          .toList();
    }

    return spells;
  }

  // 📚 Libros con caché
  Future<List<Book>> fetchBooks() async {
    const cacheKey = 'cached_books';
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$baseUrl/books');

    try {
      if (await _hasInternet()) {
        final response = await http.get(uri).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          prefs.setString(cacheKey, response.body);
          return _parseBooks(response.body);
        } else {
          throw Exception('Error ${response.statusCode}');
        }
      } else {
        final cached = prefs.getString(cacheKey);
        if (cached != null) {
          return _parseBooks(cached);
        } else {
          throw Exception('Sin internet y sin datos guardados');
        }
      }
    } catch (e) {
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        return _parseBooks(cached);
      } else {
        throw Exception('Error de red: $e');
      }
    }
  }

  List<Book> _parseBooks(String jsonStr) {
    final jsonData = json.decode(jsonStr);
    final List data = jsonData['data'];
    return data.map((item) => Book.fromJson(item)).toList();
  }

  // 🎬 Películas con caché
  Future<List<Movie>> fetchMovies() async {
    const cacheKey = 'cached_movies';
    final prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('$baseUrl/movies');

    try {
      if (await _hasInternet()) {
        final response = await http.get(uri).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          prefs.setString(cacheKey, response.body);
          return _parseMovies(response.body);
        } else {
          throw Exception('Error ${response.statusCode}');
        }
      } else {
        final cached = prefs.getString(cacheKey);
        if (cached != null) {
          return _parseMovies(cached);
        } else {
          throw Exception('Sin internet y sin datos guardados');
        }
      }
    } catch (e) {
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        return _parseMovies(cached);
      } else {
        throw Exception('Error de red: $e');
      }
    }
  }

  List<Movie> _parseMovies(String jsonStr) {
    final jsonData = json.decode(jsonStr);
    final List data = jsonData['data'];
    return data.map((item) => Movie.fromJson(item)).toList();
  }

  // Destacados
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
