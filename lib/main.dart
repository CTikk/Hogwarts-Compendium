import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_preferences_provider.dart';
import 'pages/onboarding_page.dart';
import 'utils/theme_manager.dart';
import 'pages/compendium_page.dart';
import 'provider/connectivity_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPreferencesProvider();
  await prefs.loadPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => prefs, child: MyApp(prefs: prefs)),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
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
          title: 'Hogwarts Compendium',
          theme: getThemeByHouse(userPrefs.house,),
          home: userPrefs.showTutorial
              ? const OnboardingPage()
              : const CompendiumPage(title: 'Howarts Compendium'),
        );
      },
    );
  }
}
