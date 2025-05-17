// car_detail_screen.dart
import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  final String brand;
  final String model;
  final String imageUrl;
  final String price;
  final String description;
  final String specs;

  const CarDetailScreen({
    super.key,
    required this.brand,
    required this.model,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$brand $model')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$brand $model', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(price, style: const TextStyle(fontSize: 20, color: Colors.blue)),
                  const SizedBox(height: 8),
                  Text(description),
                  const SizedBox(height: 16),
                  Text(specs, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  ElevatedButton(onPressed: () {}, child: const Text('Contact Dealer')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
