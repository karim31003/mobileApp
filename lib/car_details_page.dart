import 'package:flutter/material.dart';
import 'car.dart';

class CarDetailsPage extends StatelessWidget {
  final Car car;

  const CarDetailsPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name,style: TextStyle(color: Colors.white)) ,
      foregroundColor: Color(0xFFffffff)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                car.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              car.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Type: ${car.type}', style: const TextStyle(fontSize: 18)),
            Text('Price: \$${car.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
