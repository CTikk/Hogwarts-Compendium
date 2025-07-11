import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_preferences_provider.dart';
import 'pages/home_page.dart';
import 'utils/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferencesProvider();
  await prefs.loadPreferences();

  runApp(
    ChangeNotifierProvider(
      create: (_) => prefs,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    return MaterialApp(
      title: 'PotterDB App',
      theme: getThemeByHouse(prefs.house),
      home: const MyHomePage(title: 'Inicio'),
    );
  }
}