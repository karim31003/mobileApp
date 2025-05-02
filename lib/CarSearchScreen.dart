import 'package:flutter/material.dart';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({Key? key}) : super(key: key);

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  final List<String> carModels = [
    'Toyota Camry', 'Toyota Corolla', 'Honda Civic', 'Honda Accord',
    'BMW 3 Series', 'BMW X5', 'Mercedes-Benz C-Class', 'Ford F-150',
    'Hyundai Elantra', 'Kia Sportage', 'Nissan Altima', 'Audi A4',
    'Chevrolet Silverado', 'Tesla Model 3', 'Lexus RX'
  ];

  String query = '';
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); // 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCars = carModels
        .where((car) => car.toLowerCase().contains(query.toLowerCase()))
        .toList();

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
                    controller: _controller,
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
                        return ListTile(
                          title: Text(filteredCars[index]),
                          onTap: () {
                            setState(() {
                              query = filteredCars[index];
                              _controller.text = query;
                            });
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
