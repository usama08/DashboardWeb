class Product {
  final String imagePath;
  final String name;
  final double price;
  final double discount;

  Product(
      {required this.imagePath,
        required this.name,
        required this.price,
        this.discount = 0});
}

class Category {
  final String imagePath;
  final String label;
  Category({required this.imagePath, required this.label});
}
