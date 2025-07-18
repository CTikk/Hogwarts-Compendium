import 'package:flutter/material.dart';
import '../widgets/offline_banner.dart';
import 'package:share_plus/share_plus.dart';


class DetailPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> details;

  const DetailPage({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
      actions: [
      IconButton(
        icon: const Icon(Icons.share),
        onPressed: () {
          final shareText = details.entries
              .where((e) => e.key != 'imagen')
              .map((e) => '${e.key}: ${e.value}')
              .join('\n');

          Share.share('📚 $title\n$shareText\n\nsent from Hogwarts Compendium');
        },
      ),
    ],
    ),
      body: ListView(
        children: [
          const OfflineBanner(),
          Container(
            height: 250, // espacio limitado para la imagen
            width: double.infinity,
            color: Colors.black12,
            alignment: Alignment.center,
            child: Image.network(
              details['imagen'],
              fit: BoxFit.contain, // se ajusta al tamaño del contenedor sin recortes
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error, size: 50));
              },
            ),
          ),
          const SizedBox(height: 16),
          ...details.entries
          .where((entry) => entry.key != 'imagen')
          .map((entry) {
            return ListTile(
              title: Text(entry.key),
              subtitle: Text(entry.value.toString()),
            );
          }).toList(),

        ],
      ),
    );
  }
}
