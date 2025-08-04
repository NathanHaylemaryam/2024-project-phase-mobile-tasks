import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';  // Make sure this import exists
import '../bloc/product_state.dart';
import 'add_product_page.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    // Trigger product load when page opens
    context.read<ProductBloc>().add(GetProductEvent(productId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final state = context.read<ProductBloc>().state;
              if (state is ProductLoaded) {
                _navigateToEdit(context, state.product);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else if (state is ProductLoaded) {
            return _buildDetailView(context, state.product);  // Pass context here
          }
          return const Center(child: Text('Product not found'));
        },
      ),
    );
  }

  Widget _buildDetailView(BuildContext context, Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(product.imagepath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Category and Name
          Text(
            'product.category.toUpperCase()',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Static Size Display
          const Text(
            'Available Sizes:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [39, 40, 41, 42, 43, 44].map((size) {
              return Chip(
                label: Text(size.toString()),
                backgroundColor: Colors.grey[200],
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            product.decscription,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('DELETE'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => _confirmDelete(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('UPDATE'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => _navigateToEdit(context, product),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // In product_detail_page.dart
  void _navigateToEdit(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      '/add-product',
      arguments: product, // Pass product for editing
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              'DELETE',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              context.read<ProductBloc>().add(DeleteProductEvent(productId));  // Changed to match your event
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}