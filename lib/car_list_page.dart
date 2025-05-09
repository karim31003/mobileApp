import 'package:flutter/material.dart';
import 'car.dart';
import 'car_details_page.dart';

class CarListPage extends StatelessWidget {
  final String selectedCategory;

  CarListPage({required this.selectedCategory});

  List<Car> getCarsForCategory(String category) {
    Car car;
    switch (category) {
      case 'SUV':
        car = Car(
          imageUrl: 'assets/mustang.jpg',
          name: 'BMW X5',
          type: 'SUV',
          price: 75000,
        );
        break;
      case 'Sedan':
        car = Car(
          imageUrl: 'assets/mustang.jpg',
          name: 'Toyota Corolla',
          type: 'Sedan',
          price: 25000,
        );
        break;
      case 'Coupe':
        car = Car(
          imageUrl: 'assets/mustang1.jpg',
          name: 'Ford Mustang',
          type: 'Coupe',
          price: 55000,
        );
        break;
      case 'Hatchback':
        car = Car(
          imageUrl: 'assets/mustang1.jpg',
          name: 'Honda Civic',
          type: 'Hatchback',
          price: 23000,
        );
        break;
      default:
        car = Car(
          imageUrl: 'assets/mustang.jpg',
          name: 'Unknown Car',
          type: category,
          price: 0,
        );
    }
    return List.generate(4, (_) => car); // تكرار لنفس النوع كتجربة
  }

  @override
  Widget build(BuildContext context) {
    final cars = getCarsForCategory(selectedCategory);

    return Scaffold(
      appBar: AppBar(title: Text('Cars: $selectedCategory')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CarDetailsPage(car: car)),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      car.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(car.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('Type: ${car.type}'),
                        Text('Price: \$${car.price.toStringAsFixed(0)}'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
