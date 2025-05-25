import 'package:flutter/material.dart';
import 'car.dart';
import 'car_details_page.dart';

class CarListPage extends StatelessWidget {
  final String selectedCategory;

  CarListPage({required this.selectedCategory});

 List<Car> getCarsForCategory(String category) {
  switch (category) {
    case 'SUV':
      return [
        Car(
          imageUrl: 'assets/X6.jpg',
          name: 'BMW X6',
          type: 'SUV',
          price: 75000,
        ),
        Car(
          imageUrl: 'assets/XCeed.jpg',
          name: 'KIA XCeed',
          type: 'SUV',
          price: 18000,
        ),
        Car(
          imageUrl: 'assets/Sportage.jpg',
          name: 'KIA Sportage',
          type: 'SUV',
          price: 28000,
        ),
        Car(
          imageUrl: 'assets/Q8.jpg',
          name: 'Audi Q8',
          type: 'SUV',
          price: 80000,
        ),
      ];
    case 'Sedan':
      return [
        Car(
          imageUrl: 'assets/a4.jpg',
          name: 'Audi A3',
          type: 'Sedan',
          price: 25000,
        ),
        Car(
          imageUrl: 'assets/a3.jpg',
          name: 'Audi A4',
          type: 'Sedan',
          price: 30000,
        ),
      ];
    case 'Coupe':
      return [
        Car(
          imageUrl: 'assets/4c.jpg',
          name: 'Alfa Romeo 4c',
          type: 'Coupe',
          price: 55000,
        ),
        Car(
          imageUrl: 'assets/chevy_camaro.jpg',
          name: 'Chevrolet Camaro',
          type: 'Coupe',
          price: 53000,
        ),
      ];
    case 'Hatchback':
      return [
        Car(
          imageUrl: 'assets/honda_civic.jpg',
          name: 'Honda Civic',
          type: 'Hatchback',
          price: 23000,
        ),
        Car(
          imageUrl: 'assets/volkswagen_golf.jpg',
          name: 'Volkswagen Golf',
          type: 'Hatchback',
          price: 25000,
        ),
      ];
    default:
      return [
        // Car(
        //   imageUrl: 'assets/unknown_car.jpg',
        //   name: 'Unknown Car',
        //   type: category,
        //   price: 0,
        // ),
      ];
  }
}

  @override
  Widget build(BuildContext context) {
    final cars = getCarsForCategory(selectedCategory);

    return Scaffold(
      appBar: AppBar(title: Text('Cars: $selectedCategory',style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 20)),backgroundColor: Colors.blueAccent,foregroundColor: Colors.white,),
      backgroundColor: Colors.white,
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
                        Text('Price: \€ ${car.price.toStringAsFixed(0)}'),
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
