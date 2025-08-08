import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../pages/details._page.dart';

class ProductEntity extends StatelessWidget {
  final Product product;

  const ProductEntity({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailsPage()),
            ),
            child: Image.asset(
              'lib/images/1.jpg', // Optionally use product.imagepath if available
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text('\$${product.price}', style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mens shoe',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(170, 170, 170, 1),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      color: Color.fromRGBO(255, 215, 0, 1),
                    ),
                    Text(
                      '( 4.0)',
                      style: TextStyle(
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
