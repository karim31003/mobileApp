import 'package:flutter/material.dart';
import 'car_list_page.dart';

class CarTypesPage extends StatelessWidget {
  final List<String> categories = ['SUV', 'Sedan', 'Coupe', 'Hatchback'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Car Types',style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Color(0xFFffffff)),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final type = categories[index];
          return ListTile(
            title: Text(type),
            trailing: const Icon(Icons.arrow_forward_ios),
           
            onTap: () {
              Navigator.push(
                context,
                
                MaterialPageRoute(
                  builder: (_) => CarListPage(selectedCategory: type),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
