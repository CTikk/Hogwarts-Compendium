import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';
import 'home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String selectedHouse = 'Gryffindor';
  bool doNotShowAgain = false;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración inicial')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Nombre de usuario'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Tu nombre'),
            ),
            const SizedBox(height: 20),
            const Text('Selecciona tu casa de Hogwarts'),
            DropdownButton<String>(
              value: selectedHouse,
              onChanged: (value) => setState(() => selectedHouse = value!),
              items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                  .map((house) => DropdownMenuItem(
                        value: house,
                        child: Text(house),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('No volver a mostrar'),
              value: doNotShowAgain,
              onChanged: (val) => setState(() => doNotShowAgain = val ?? false),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await prefs.updateHouse(selectedHouse);
                if (doNotShowAgain) await prefs.disableTutorial();
                // Aquí puedes guardar también el nombre si lo deseas
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyHomePage(title: 'Inicio'),
                  ),
                );
              },
              child: const Text('Guardar y continuar'),
            )
          ],
        ),
      ),
    );
  }
}
