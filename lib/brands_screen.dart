import 'package:flutter/material.dart';
import 'models_screen.dart';
import 'car_data.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final brands = brandModels.keys.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Select Brand'),backgroundColor: Colors.blueAccent),
      body: ListView.builder(
        itemCount: brands.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(brands[i]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => ModelsScreen(brand: brands[i])),
          ),
        ),
      ),
    );
  }
}