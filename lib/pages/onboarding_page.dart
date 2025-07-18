import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/user_preferences_provider.dart';
import 'compendium_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String selectedHouse = 'Gryffindor';
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Get Started')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Nickname'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Your nickname'),
            ),
            const SizedBox(height: 20),
            const Text('Choose your Hogwarts house'),
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
            const Text('Select a profile image'),
            const SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage('assets/user.png') as ImageProvider,
                  child: _selectedImage == null
                      ? const Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await prefs.updateHouse(selectedHouse);
                await prefs.updateUserName(_nameController.text);
                if (_selectedImage != null) {
                  await prefs.updateProfileImagePath(_selectedImage!.path);
                }
                await prefs.disableTutorial();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CompendiumPage(title: 'Hogwarts Compendium'),
                  ),
                );
              },
              child: const Text('Finish setup'),
            )
          ],
        ),
      ),
    );
  }
}
