import 'package:flutter/material.dart';
import 'car.dart';
import 'car_detail_screen.dart'; // استيراد شاشة تفاصيل السيارة

class CarListPage extends StatelessWidget {
  final String selectedCategory;

  // الكونستركتور مع استقبال تصنيف السيارات المحدد
  CarListPage({required this.selectedCategory});

  // دالة ترجع قائمة السيارات حسب التصنيف المحدد
  List<Car> getCarsForCategory(String category) {
    switch (category) {
      case 'SUV':
        // قائمة سيارات SUV
        return [
          Car(
            imageUrl: 'assets/X6.jpg',
            brand: 'BMW',
            model: 'X6',
            type: 'SUV',
            price: 75000,
          ),
          Car(
            imageUrl: 'assets/XCeed.jpg',
            brand: 'KIA',
            model: 'XCeed',
            type: 'SUV',
            price: 18000,
          ),
          Car(
            imageUrl: 'assets/Sportage.jpg',
            brand: 'KIA',
            model: 'Sportage',
            type: 'SUV',
            price: 28000,
          ),
          Car(
            imageUrl: 'assets/Q8.jpg',
            brand: 'Audi',
            model: 'Q8',
            type: 'SUV',
            price: 80000,
          ),
        ];
      case 'Sedan':
        // قائمة سيارات Sedan
        return [
          Car(
            imageUrl: 'assets/a4.jpg',
            brand: 'Audi',
            model: 'A3',
            type: 'Sedan',
            price: 25000,
          ),
          Car(
            imageUrl: 'assets/a3.jpg',
            brand: 'Audi',
            model: 'A4',
            type: 'Sedan',
            price: 30000,
          ),
        ];
      case 'Coupe':
        // قائمة سيارات Coupe
        return [
          Car(
            imageUrl: 'assets/4c.jpg',
            brand: 'Alfa Romeo',
            model: '4c',
            type: 'Coupe',
            price: 55000,
          ),
          Car(
            imageUrl: 'assets/chevy_camaro.jpg',
            brand: 'Chevrolet',
            model: 'Camaro',
            type: 'Coupe',
            price: 53000,
          ),
        ];
      case 'Hatchback':
        // قائمة سيارات Hatchback
        return [
          Car(
            imageUrl: 'assets/honda_civic.jpg',
            brand: 'Honda',
            model: 'Civic',
            type: 'Hatchback',
            price: 23000,
          ),
          Car(
            imageUrl: 'assets/volkswagen_golf.jpg',
            brand: 'Volkswagen',
            model: 'Golf',
            type: 'Hatchback',
            price: 25000,
          ),
        ];
      default:
        // لو التصنيف غير موجود، ترجع قائمة فارغة
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على قائمة السيارات المناسبة للتصنيف المحدد
    final cars = getCarsForCategory(selectedCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cars: $selectedCategory', // عنوان الشاشة مع اسم التصنيف
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      // قائمة تمرير عمودية للسيارات
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            onTap: () {
              // عند الضغط على السيارة، تقسيم الاسم إلى ماركة وطراز
              final parts = car.name.split(' ');
              final brand = parts.first;
              final model = parts.sublist(1).join(' ');

              // الانتقال لشاشة تفاصيل السيارة مع تمرير الماركة والطراز
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CarDetailScreen(brand: brand, model: model),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Column(
                children: [
                  // عرض صورة السيارة مع حواف دائرية في الأعلى
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
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
                        // اسم السيارة (ماركة + طراز) بخط عريض
                        Text(car.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        // نوع السيارة (SUV, Sedan, ...الخ)
                        Text('Type: ${car.type}'),
                        // سعر السيارة مع تنسيق مناسب
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
