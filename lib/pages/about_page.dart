import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hogwarts Compendium",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Version 1.1.0\n\n"
              "Hogwarts Compendium is a fan-made Flutter app for Harry Potter enthusiasts.\n\n"
              "Explore characters, spells, books, and movies in one magical place.\n\n"
              "Developed by Pablo Escobar and Valentine Sierra.\n"
              "Powered by PotterDB API.",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: Text(
                "© 2025 Hogwarts Compendium",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
