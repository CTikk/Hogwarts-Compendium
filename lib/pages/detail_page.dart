import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> details;

  const DetailPage({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
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
