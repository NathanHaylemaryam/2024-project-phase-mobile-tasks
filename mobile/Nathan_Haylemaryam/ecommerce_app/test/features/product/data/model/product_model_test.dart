import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';

void main() {
  const productModel = ProductModel(
    id: 1,
    name: 'Nike Air Max',
    decscription: 'Running shoes',
    price: '120.00',
    imagepath: 'assets/images/shoe1.png',
  );

  final productJson = {
    'id': 1,
    'name': 'Nike Air Max',
    'description': 'Running shoes',
    'price': '120.00',
    'image_path': 'assets/images/shoe1.png',
  };

  group('ProductModel', () {
    test('should be a subclass of Product entity', () {
      expect(productModel, isA<Product>());
    });

    test('fromJson should return a valid model', () {
      final result = ProductModel.fromJson(productJson);

      expect(result, equals(productModel));
    });

    test('toJson should return a valid map containing proper data', () {
      final result = productModel.toJson();

      expect(result, productJson);
    });
  });
}
