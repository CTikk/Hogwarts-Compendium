import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String selectedHouse = 'Gryffindor';
  bool doNotShowAgain = false;

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias Iniciales')),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedHouse,
            items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                .map((h) => DropdownMenuItem(value: h, child: Text(h)))
                .toList(),
            onChanged: (value) {
              setState(() => selectedHouse = value!);
            },
          ),
          CheckboxListTile(
            title: const Text("No volver a mostrar"),
            value: doNotShowAgain,
            onChanged: (val) {
              setState(() => doNotShowAgain = val!);
            },
          ),
          ElevatedButton(
            onPressed: () {
              prefs.updateHouse(selectedHouse);
              if (doNotShowAgain) prefs.disableTutorial();
              Navigator.pop(context);
            },
            child: const Text("Guardar y continuar"),
          ),
        ],
      ),
    );
  }
}
