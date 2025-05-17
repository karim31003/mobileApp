import 'package:flutter/material.dart';
import 'car_data.dart';

class CarDetailScreen extends StatelessWidget {
  final String brand, model;
  const CarDetailScreen({super.key, required this.brand, required this.model});
  
  @override
  Widget build(BuildContext context) {
    final details = modelDetails[model];
    if (details == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$brand $model'),
          elevation: 0,
        ),
        body: const Center(child: Text('Details not available')),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Color(0xFFffffff),
        title: Text('$brand $model',style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          //dont delete
          // IconButton(
          //   icon: const Icon(Icons.favorite_border),
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('Added to favorites')),
          //     );
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image section with zoom effect
            SizedBox(
              height: 250, // Increased height for better visibility
              width: double.infinity,
              child: Hero(
                tag: 'car-${brand.toLowerCase()}-${model.toLowerCase()}',
                child: Image.asset(
                  details['image']!,
                  width: double.infinity,
                  fit: BoxFit.cover, // Zoomed effect with cover fit
                  errorBuilder: (context, error, stackTrace) {
                    // Return placeholder on error
                    return Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.directions_car, size: 70, color: Colors.grey[600]),
                          const SizedBox(height: 12),
                          Text('$brand $model', 
                              style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Car details part
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$brand $model',
                          style: const TextStyle(
                            fontSize: 26, 
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Text(
                        details['price']!,
                        style: const TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          details['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.speed, size: 18, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              details['specs']!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Contact button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contact request sent!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Contact Dealer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Test drive option
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Test drive requested!')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Schedule Test Drive'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}