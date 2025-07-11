import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil de Usuario"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/user.png"),
                ),
                const SizedBox(height: 10),
                Text(
                  "Correo electrónico: usuario@ejemplo.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Miembro de ${prefs.house}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String selectedHouse = prefs.house;
                            return AlertDialog(
                              title: const Text("Selecciona tu casa"),
                              content: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedHouse,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    selectedHouse = value;
                                    // setState no disponible aquí → se guarda al presionar "Guardar"
                                  }
                                },
                                items: [
                                  'Gryffindor',
                                  'Slytherin',
                                  'Ravenclaw',
                                  'Hufflepuff'
                                ].map((house) {
                                  return DropdownMenuItem(
                                    value: house,
                                    child: Text(house),
                                  );
                                }).toList(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancelar"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await prefs.updateHouse(selectedHouse);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Guardar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_2),
            title: const Text("Personajes Favoritos"),
            subtitle: Text('No disponible'),
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: const Text("Hechizos Favoritos"),
            subtitle: Text('No disponible'),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text("Libros Favoritos"),
            subtitle: Text('No disponible'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text("Películas Favoritas"),
            subtitle: Text('No disponible'),
          ),
          const Divider()
        ],
      ),
    );
  }
}
