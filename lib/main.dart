// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this to use GetMaterialApp
import 'package:joshuas_shop/models/product.dart';
import 'package:joshuas_shop/themes/theme.dart';
// ignore: unnecessary_import
import 'package:flutter/animation.dart'; // Required for AnimatedSlide

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
  }

  List<Product> products = [
    Product(name: 'Chuchu Pads', imageUrl: 'assets/images/Img1.jpg', price: 29.99),
    Product(name: 'Baby Boy', imageUrl: 'assets/images/Img2.jpg', price: 49.99),
    Product(name: 'Ladies', imageUrl: 'assets/images/Img3.jpg', price: 19.99),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Joshuas Shop',
      theme: isDarkTheme ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: CatalogPage(toggleTheme: toggleTheme, products: products),
    );
  }
}

class CatalogPage extends StatelessWidget {
  final Function(bool) toggleTheme;
  final List<Product> products;

  const CatalogPage({super.key, required this.toggleTheme, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Joshuas Shop',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Switch widget to toggle theme
          Switch(
            value: Get.isDarkMode, // Use Get to determine the current mode
            onChanged: toggleTheme,
            activeColor: Colors.yellow, // Color of the switch when active
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, // Adjust aspect ratio for better card shape
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              _showCustomAnimatedDialog(context, product); // Call custom animated dialog
            },
            child: Card(
              margin: const EdgeInsets.all(10), // Adds margin around the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8, // Adds shadow
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(product.name, textAlign: TextAlign.center),
                        Text('\$${product.price.toStringAsFixed(2)}', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to show a custom animated dialog
  void _showCustomAnimatedDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allows tapping outside to dismiss
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: AnimatedSlide(
            offset: const Offset(0, 0.2), // Start offset for animation
            duration: const Duration(milliseconds: 500), // Animation duration
            child: SizedBox(
              width: 300, // Set width for the dialog
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 150, // Adjust height for the dialog
                        width: double.infinity, // Set width to full
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}