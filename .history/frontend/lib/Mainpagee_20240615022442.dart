// main_page.dart
import 'package:flutter/material.dart';
import 'photographer_page.dart';

class MainPage extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Photographers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Enter Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final location = locationController.text;
                if (location.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotographerPage(location: location),
                    ),
                  );
                } else {
                  // Show an error if the location is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a location')),
                  );
                }
              },
              child: const Text('Find Top Photographers'),
            ),
          ],
        ),
      ),
    );
  }
}
