import 'package:flutter/material.dart';

class LocationDetailPage extends StatelessWidget {
  final String locationName;
  final String image;
  final int stars;
  final int price;
  final String owner;
  final String address;

  const LocationDetailPage({
    Key? key,
    required this.locationName,
    required this.image,
    required this.stars,
    required this.price,
    required this.owner,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(locationName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                stars,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price of Rent: \$${price.toString()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price of Rent: \$${price.toString()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Location: $address',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle live location click
                // You can integrate Google Maps or any other live location feature here
              },
              child: const Text('View Live Location'),
            ),
          ],
        ),
      ),
    );
  }
}
