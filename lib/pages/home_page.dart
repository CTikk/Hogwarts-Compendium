import 'package:flutter/material.dart';
import 'package:proyecto_3/pages/profile_page.dart';
import 'compendium_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Column(
          children: [
            Text("Hogwarts Compendium", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila superior: Compendio y Perfil
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Connectivity().checkConnectivity().then((connectivityResult) {
                          if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CompendiumPage(title: 'Compendio'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Sin conexión a internet. No se puede acceder al compendio.'),
                              ),
                            );
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(Icons.menu_book, size: 40),
                            const SizedBox(height: 10),
                            Text('Compendio', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfilePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(Icons.person, size: 40),
                            const SizedBox(height: 10),
                            Text('Perfil', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🪄 Bienvenido al Compendio Mágico de Hogwarts Compendium 🪄',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Te damos la más cordial bienvenida a Hogwarts Compendium, tu portal oficial al vasto y encantador universo de Harry Potter. '
                  'Esta aplicación ha sido diseñada para todos los magos, brujas y muggles curiosos que deseen explorar en profundidad '
                  'el legado mágico creado por J.K. Rowling.',
                  style: TextStyle(fontSize: 16, color: theme.primaryColorDark),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                Text('Aquí encontrarás un compendio completo con información detallada sobre:',
                    style: TextStyle(fontSize: 16, color: theme.primaryColorDark)),
                const SizedBox(height: 8),
                ...[
                  '• 🧙‍♂️ Personajes: Perfiles de estudiantes, profesores, criaturas y figuras legendarias.',
                  '• ✨ Hechizos: Encantamientos, maldiciones y hechizos defensivos con efectos y conjuros.',
                  '• 📚 Libros: Detalles importantes y fechas de publicación de cada entrega literaria.',
                  '• 🎬 Películas: Información sobre los filmes, directores y fechas de estreno.',
                ].map((text) => Text(text, style: TextStyle())),
                const SizedBox(height: 16),
                Text('Además, podrás:', style: TextStyle(fontSize: 16, color: theme.primaryColorDark)),
                const SizedBox(height: 8),
                ...[
                  '• 🏠 Seleccionar tu casa de Hogwarts para personalizar la app.',
                  '• 🔍 Buscar fácilmente cualquier contenido.',
                  '• 👤 Acceder a tu perfil de usuario y modificar tus preferencias.',
                ].map((text) => Text(text, style: TextStyle())),
                const SizedBox(height: 16),
                Text(
                  'Esta aplicación utiliza datos de la API oficial de PotterDB, una fuente confiable y abierta de conocimiento mágico para toda la comunidad fanática del mundo de Harry Potter.',
                  style: TextStyle(fontSize: 16, color: theme.primaryColorDark),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.info_outline),
                label: const Text("Acerca de"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  foregroundColor: theme.primaryColorLight,
                ),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Hogwarts Compendium',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(Icons.school),
                    children: const [
                      SizedBox(height: 10),
                      Text('Desarrolladores:\n• Pablo Escobar\n• Valentine Sierra'),
                      SizedBox(height: 10),
                      Text('Datos proporcionados por la API pública de PotterDB:\nhttps://potterdb.com/'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
