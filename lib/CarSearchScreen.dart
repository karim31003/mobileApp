import 'package:flutter/material.dart';
import 'car_detail_screen.dart';
import 'car_data.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({Key? key}) : super(key: key);

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  late final Map<String, Map<String, String>> carModels;
  
  // Static list to persist recent cars across screen navigations
  static List<String> recentlyViewed = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    carModels = {
      for (final brandEntry in brandModels.entries)
        for (final model in brandEntry.value)
          if (modelDetails.containsKey(model) && modelDetails[model]!['image'] != null)
            '${brandEntry.key} $model': {
              'brand': brandEntry.key,
              'model': model,
              'price': modelDetails[model]!['price'] ?? '',
              'description': modelDetails[model]!['description'] ?? '',
              'specs': modelDetails[model]!['specs'] ?? '',
              'image': modelDetails[model]!['image']!,
            },
    };
  }

  void _addToRecent(String carName) {
    setState(() {
      // Remove if already exists to avoid duplicates
      recentlyViewed.remove(carName);
      // Add to beginning
      recentlyViewed.insert(0, carName);
      // Keep only last 10
      if (recentlyViewed.length > 10) {
        recentlyViewed = recentlyViewed.sublist(0, 10);
      }
    });
  }

  Widget _buildRecentCar(String carName) {
    final car = carModels[carName]!;
    return GestureDetector(
      onTap: () {
        _addToRecent(carName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailScreen(
              brand: car['brand']!,
              model: car['model']!,
            ),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                car['image']!,
                width: 140,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 124, // Fixed width to prevent overflow
                    child: Text(
                      car['brand']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 124, // Fixed width to prevent overflow
                    child: Text(
                      car['model']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (car['price']!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    SizedBox(
                      width: 124, // Fixed width to prevent overflow
                      child: Text(
                        car['price']!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCars = carModels.keys
        .where((car) => car.toLowerCase().contains(query.toLowerCase()))
        .toList()
      ..sort();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Find a Great Deal',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                _addToRecent(carName);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarDetailScreen(
                                      brand: carModels[carName]!['brand']!,
                                      model: carModels[carName]!['model']!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Recently Viewed Section - Simplified and Always Scrollable
                if (recentlyViewed.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recently Viewed',
                        style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            recentlyViewed.clear();
                          });
                        },
                        child: const Text('Clear All', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentlyViewed.length,
                      itemBuilder: (context, index) => _buildRecentCar(recentlyViewed[index]),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}