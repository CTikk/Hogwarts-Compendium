import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider with ChangeNotifier {
  String _house = 'Gryffindor';
  bool _showTutorial = true;
  String _userName = 'Usuario';
  Map<String, List<String>> _favorites = {
    'characters': [],
    'spells': [],
    'books': [],
    'movies': [],
  };
  String? _profileImagePath;

  String get house => _house;
  bool get showTutorial => _showTutorial;
  String get userName => _userName;
  Map<String, List<String>> get favorites => _favorites;
  String? get profileImagePath => _profileImagePath;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _house = prefs.getString('house') ?? 'Gryffindor';
    _userName = prefs.getString('userName') ?? 'Usuario';
    _showTutorial = prefs.getBool('showTutorial') ?? true;
    _profileImagePath = prefs.getString('profileImagePath');

    _favorites = {
      'characters': prefs.getStringList('favorites_characters') ?? [],
      'spells': prefs.getStringList('favorites_spells') ?? [],
      'books': prefs.getStringList('favorites_books') ?? [],
      'movies': prefs.getStringList('favorites_movies') ?? [],
    };
    notifyListeners();
  }

  Future<void> updateHouse(String house) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('house', house);
    _house = house;
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    _userName = name;
    notifyListeners();
  }

  Future<void> disableTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showTutorial', false);
    _showTutorial = false;
    notifyListeners();
  }

  Future<void> updateProfileImagePath(String path) async {
    _profileImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImagePath', path);
    notifyListeners();
  }

  Future<void> toggleFavorite(String category, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = _favorites[category] ?? [];

    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }

    _favorites[category] = current;
    await prefs.setStringList('favorites_$category', current);
    notifyListeners();
  }

  bool isFavorite(String category, String id) {
    return _favorites[category]?.contains(id) ?? false;
  }
}
