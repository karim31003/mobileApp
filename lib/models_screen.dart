import 'package:flutter/material.dart';
import 'car_detail_screen.dart';
import 'car_data.dart';

class ModelsScreen extends StatelessWidget {
  final String brand;
  const ModelsScreen({super.key, required this.brand});
  @override
  Widget build(BuildContext context) {
    final models = brandModels[brand] ?? [];
    return Scaffold(
      appBar: AppBar(title: Text('$brand Models',style: TextStyle(color: Colors.white)),backgroundColor: Colors.blueAccent, foregroundColor: Color(0xFFffffff),),

      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(models[i]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (_) => CarDetailScreen(brand: brand, model: models[i]),
            ),
          ),
        ),
      ),
    );
  }
}
