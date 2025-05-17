import 'package:flutter/material.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({Key? key}) : super(key: key);

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  final Map<String, Map<String, String>> carModels = {
    'Alfa Romeo Giulia': {
      'brand': 'Alfa Romeo',
      'model': 'Giulia',
      'image': '../assets/Alfa Romeo Giulia.jpg',
      'price': '45.480 €',
      'description': 'Giulia Veloce 2.0l AT8 280PS "Leder"LED"Navi',
      'specs': '8,0 l/100 km kombiniert · 182 g/km CO₂-Emissionen',
    },
    "Audi A4": {
      "brand": "Audi",
      "model": "A4",
      "image": "../assets/Audi A4.jpg",
      "price": "42,000 €",
      "description": "Audi A4 2.0 TFSI 190PS S tronic LED Navi",
      "specs": "6.5 l/100 km kombiniert · 150 g/km CO₂"
    },
    "BMW 3 Series": {
      "brand": "BMW",
      "model": "3 Series",
      "image": "../assets/BMW 3 Series.avif",
      "price": "40,000 €",
      "description": "BMW 3 Series 330i Sedan 2.0L, 286PS, 6-speed manual",
      "specs": "6.5 l/100 km kombiniert · 149 g/km CO₂"
    },
    "BMW X5": {
      "brand": "BMW",
      "model": "X5",
      "image": "../assets/bmw_x5.jpg",
      "price": "52,000 €",
      "description": "BMW X5 xDrive40i 3.0L, 381PS, 9-speed automatic",
      "specs": "9.9 l/100 km kombiniert · 224 g/km CO₂"
    },
    "Chevrolet Silverado": {
      "brand": "Chevrolet",
      "model": "Silverado",
      "image": "../assets/Chevrolet Silverado.jpeg",
      "price": "32,000 €",
      "description": "Chevrolet Silverado 1500 5.3L V8, 355PS, 6-speed automatic",
      "specs": "8.0 l/100 km kombiniert · 180 g/km CO₂"
    },
    "Ford F-150": {
      "brand": "Ford",
      "model": "F-150",
      "image": "../assets/Ford F-150.avif",
      "price": "50,000 €",
      "description": "Ford F-150 3.5L EcoBoost V6, 400PS, 10-speed automatic",
      "specs": "4.9 l/100 km kombiniert · 115 g/km CO₂"
    },
    "Honda Accord": {
      "brand": "Honda",
      "model": "Accord",
      "image": "../assets/honda_accord.jpg",
      "price": "22,000 €",
      "description": "Honda Accord 2.0L, 190PS, CVT transmission",
      "specs": "6.1 l/100 km kombiniert · 140 g/km CO₂"
    },
    "Honda Civic": {
      "brand": "Honda",
      "model": "Civic",
      "image": "../assets/Honda Civic.jpg",
      "price": "30,000 €",
      "description": "Honda Civic 1.5L Turbo, 182PS, CVT transmission",
      "specs": "7.5 l/100 km kombiniert · 172 g/km CO₂"
    },
    "Hyundai Elantra": {
      "brand": "Hyundai",
      "model": "Elantra",
      "image": "../assets/Hyundai Elantra.jpeg",
      "price": "35,000 €",
      "description": "Hyundai Elantra 2.0L, 147PS, 6-speed automatic",
      "specs": "5.4 l/100 km kombiniert · 125 g/km CO₂"
    },
    "Kia Sportage": {
      "brand": "Kia",
      "model": "Sportage",
      "image": "assets/Sportage.jpg",
      "price": "76,000 €",
      "description": "Kia Sportage 1.6L Turbo Hybrid, 230PS, 6-speed automatic",
      "specs": "9.0 l/100 km kombiniert · 210 g/km CO₂"
    },
    "Lexus RX": {
      "brand": "Lexus",
      "model": "RX",
      "image": "../assets/Lexus RX.avif",
      "price": "49,590 €",
      "description": "Lexus RX 350h 2.5L Hybrid, 246PS, CVT transmission",
      "specs": "7.8 l/100 km kombiniert · 188 g/km CO₂"
    },
    "Mercedes-Benz C-Class": {
      "brand": "Mercedes-Benz",
      "model": "C-Class",
      "image": "../assets/Mercedes-Benz C-Class.jpg",
      "price": "55,000 €",
      "description": "Mercedes-Benz C-Class C300 2.0L, 258PS, 9-speed automatic",
      "specs": "6.3 l/100 km kombiniert · 148 g/km CO₂"
    },
    "Nissan Altima": {
      "brand": "Nissan",
      "model": "Altima",
      "image": "../assets/Nissan Altima.jpg",
      "price": "43,000 €",
      "description": "Nissan Altima 2.5L, 188PS, CVT transmission",
      "specs": "4.6 l/100 km kombiniert · 110 g/km CO₂"
    },
    "Tesla Model 3": {
      "brand": "Tesla",
      "model": "Model 3",
      "image": "../assets/Tesla Model 3.webp",
      "price": "42,741 €",
      "description": "Tesla Model 3 Long Range AWD, 351PS, Electric",
      "specs": "6.7 l/100 km kombiniert · 155 g/km CO₂"
    },
    "Toyota Camry": {
      "brand": "Toyota",
      "model": "Camry",
      "image": "../assets/Toyota Camry.png",
      "price": "15,000 €",
      "description": "Toyota Camry 2.5L, 203PS, CVT transmission",
      "specs": "5.2 l/100 km kombiniert · 120 g/km CO₂"
    },
    "Toyota Corolla": {
      "brand": "Toyota",
      "model": "Corolla",
      "image": "../assets/Toyota Corolla.jpg",
      "price": "25,000 €",
      "description": "Toyota Corolla 1.8L, 140PS, CVT transmission",
      "specs": "7.2 l/100 km kombiniert · 165 g/km CO₂"
    },
  };

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredCars = carModels.keys
        .where((car) => car.toLowerCase().contains(query.toLowerCase()))
        .toList()
      ..sort();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Find a Great Deal',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search by Car Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: filteredCars.length,
                      itemBuilder: (context, index) {
                        final carName = filteredCars[index];
                        return ListTile(
                          title: Text(carName),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarImageScreen(
                                  carName: carName,
                                  imageUrl: carModels[carName]!['image']!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}

class CarImageScreen extends StatelessWidget {
  final String carName;
  final String imageUrl;

  const CarImageScreen({required this.carName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carName),
      ),
      body: Center(
        child: Image.asset(imageUrl),
      ),
    );
  }
}