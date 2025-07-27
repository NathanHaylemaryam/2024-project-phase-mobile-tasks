import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String name,
    required String decscription,
    required String price,
    required String imagepath,
    required int id,
  }) : super(
    name: name,
    decscription: decscription,
    price: price,
    imagepath: imagepath,
    id: id,
  );

  /// Factory constructor to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      decscription: json['description'], // Watch the spelling
      price: json['price'],
      imagepath: json['image_path'], // Snake_case is common in APIs
      id: json['id'],
    );
  }

  /// Convert ProductModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': decscription,
      'price': price,
      'image_path': imagepath,
      'id': id,
    };
  }
}
