import 'package:ecommerce_app/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required String name,
    required String decscription,
    required int price,
    required String imagepath,
    required String id,
  }) : super(
    name: name,
    decscription: decscription,
    price: price,
    imagepath: imagepath,
    id: id,
  );

  /// Factory constructor to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(name: json['name'], decscription: json['description'], price: json['price'], imagepath: json['imageUrl'], id: json['id']);
    // print(json);
    // return ProductModel(
    //   name: json['name'],
    //   decscription: json['description'], // Watch the spelling
    //   price: json['price'],
    //   imagepath: json['imageUrl'], // Snake_case is common in APIs
    //   id: json['id'],
    // );


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
  Product toEntity() {
    return const Product(
        id: '1',
        name: 'name',
        decscription: 'description',
        price: 7,
        imagepath: ''
    );
  }
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      decscription: product.decscription,
      price: product.price,
      imagepath: product.imagepath,
    );
  }

}


