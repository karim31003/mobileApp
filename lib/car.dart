class Car {
  final String imageUrl;
  final String brand;
  final String model;
  final String type;
  final double price;

  Car({
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.type,
    required this.price,
  });

  String get name => '$brand $model';
}
