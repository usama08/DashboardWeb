import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class ProductListingScreen extends StatelessWidget {
  final List<Product> products = List.generate(20, (index) {
    return Product(
      name: 'Product ${index + 1}',
      description: 'This is a description for Product ${index + 1}.',
      price: (index + 1) * 10.0,
      imageUrl: 'assets/product_image.png',
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
        // backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: EdgeInsets.all(10.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(product.imageUrl),
              ),
              title: Text(
                product.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.description),
                  SizedBox(height: 5.0),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.blueAccent,
                  size: 28.0,
                ),
                onPressed: () {
                  // Handle add to cart action here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
