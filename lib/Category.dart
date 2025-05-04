import 'package:flutter/material.dart';
import 'car.dart';




class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _HomePageState();
}

class _HomePageState extends State<Category> {
  final List<String> categories = ['SUV', 'Sedan', 'Coupe', 'Hatchback'];
  String selectedCategory = 'SUV';
//  ولو المستخدم ضغط على اي نوع تاني يفتحله الصور بتاعته بكل روقااااااااااان SUVهنا عملت ان الافتراضي يبقى 
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
    return List.generate(4, (_) => car);
  }

  @override
  Widget build(BuildContext context) {
    final cars = getCarsForCategory(selectedCategory);

    return Scaffold(
      appBar: AppBar(title: const Text('Car Marketplace')),
      body: Row(
        children: [
          Container(
            width: 150,
            color: Colors.grey[200],
            child: Column(
              children: [
                const SizedBox(height: 15),
                // سهم الرجوع طلعته فوق العنوان
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Center(
                    child: Text(
                      'Car Types',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: categories.map((type) {
                      return ListTile(
                        title: Text(type),
                        selected: type == selectedCategory,
                        onTap: () {
                          setState(() {
                            selectedCategory = type;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return SizedBox(
                    height: 300, 
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              car.imageUrl,
                              fit: BoxFit.cover,
                              height: 160, 
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ⬇️  اسم العربية
                                Text(
                                  car.name,
                                  style: const TextStyle(
                                    fontSize: 16, // كان 20
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Type: ${car.type}',
                                  style: const TextStyle(fontSize: 14), // كان 16
                                ),
                                Text(
                                  'Price: \$${car.price.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 14), // كان 16
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}