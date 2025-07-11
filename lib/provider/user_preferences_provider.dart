import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider with ChangeNotifier {
  String _house = 'Gryffindor';
  bool _showTutorial = true;

  String get house => _house;
  bool get showTutorial => _showTutorial;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _house = prefs.getString('house') ?? 'Gryffindor';
    _showTutorial = prefs.getBool('showTutorial') ?? true;
    notifyListeners();
  }

  Future<void> updateHouse(String house) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('house', house);
    _house = house;
    notifyListeners();
  }

  Future<void> disableTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showTutorial', false);
    _showTutorial = false;
    notifyListeners();
  }
}