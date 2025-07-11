import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_preferences_provider.dart';
import 'pages/home_page.dart';
import 'pages/onboarding_page.dart';
import 'utils/theme_manager.dart'; // Asegúrate de importar esto

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferencesProvider();
  await prefs.loadPreferences();

  runApp(
    ChangeNotifierProvider(
      create: (_) => prefs,
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserPreferencesProvider prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPreferencesProvider>(
      builder: (context, userPrefs, _) {
        return MaterialApp(
          title: 'PotterDB App',
          theme: getThemeByHouse(userPrefs.house), // ✅ Tema según la casa
          home: userPrefs.showTutorial
              ? const OnboardingPage()
              : const MyHomePage(title: 'Inicio'),
        );
      },
    );
  }
}
