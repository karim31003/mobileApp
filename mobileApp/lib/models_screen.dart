import 'package:flutter/material.dart';
import 'car_detail_screen.dart';
import 'car_data.dart';
class ModelsScreen extends StatelessWidget {
  final String brand;

  const ModelsScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final models = {
      'Alfa Romeo': ['Giulia', 'Stelvio', 'Tonale', 'Discontinued Models', '4C Coupe'],
      'Audi': ['A3', 'A4', 'A6', 'Q5', 'Q7'],
      // Add other brands...
    };

    // This should match exactly the same carModels map you used in search screen
    // final Map<String, Map<String, String>> carModels = {
    //   'Giulia': {
    //     'brand': 'Alfa Romeo',
    //     'model': 'Giulia',
    //     'image': 'https://example.com/images/giulia.jpg',
    //     'price': '45.480 €',
    //     'description': 'Giulia Veloce 2.0l AT8 280PS "Leder"LED"Navi',
    //     'specs': '8,0 l/100 km kombiniert · 182 g/km CO₂-Emissionen',
    //   },
    //   'A4': {
    //     'brand': 'Audi',
    //     'model': 'A4',
    //     'image': 'https://example.com/images/audi_a4.jpg',
    //     'price': '42.000 €',
    //     'description': 'Audi A4 2.0 TFSI 190PS S tronic LED Navi',
    //     'specs': '6,5 l/100 km kombiniert · 150 g/km CO₂',
    //   },
    //   // Add more models if you want them to show details
    // };

    return Scaffold(
      appBar: AppBar(title: Text('$brand Models')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: models[brand]!.map((model) {
                return ListTile(
                  title: Text(model),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    final car = modelDetails[model];
                    if (car != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarDetailScreen(
                            brand: car['brand']!,
                            model: car['model']!,
                            imageUrl: car['image']!,
                            price: car['price']!,
                            description: car['description']!,
                            specs: car['specs']!,
                          ),
                        ),
                      );
                    } else {
                      // fallback dummy data if model not found
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarDetailScreen(
                            brand: brand,
                            model: model,
                            imageUrl: 'https://via.placeholder.com/400x200?text=No+Image',
                            price: 'N/A',
                            description: 'No details available for this model.',
                            specs: 'N/A',
                          ),
                        ),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
