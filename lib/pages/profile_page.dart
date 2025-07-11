import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 50, backgroundImage: AssetImage("assets/user.png")),
          Text("Casa: ${prefs.house}", style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}