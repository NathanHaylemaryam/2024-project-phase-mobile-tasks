import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/utils/product_input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductInputConverter converter;

  setUp(() {
    converter = ProductInputConverter();
  });

  const validId = 1;

  test('should return Product when all inputs are valid', () {
    final result = converter.convertFormToProduct(
      name: 'Phone',
      description: 'Nice device',
      priceStr: '999.99',
      imagePath: 'assets/img.jpg',
      id: validId,
    );

    expect(result.isRight(), true);
  });

  test('should return InvalidNameFailure when name is empty', () {
    final result = converter.convertFormToProduct(
      name: '',
      description: 'Desc',
      priceStr: '100',
      imagePath: 'img.jpg',
      id: validId,
    );

    expect(result, Left(InvalidNameFailure()));
  });

  test('should return InvalidPriceFailure for invalid price string', () {
    final result = converter.convertFormToProduct(
      name: 'Test',
      description: 'Desc',
      priceStr: 'abc',
      imagePath: 'img.jpg',
      id: validId,
    );

    expect(result, Left(InvalidPriceFailure()));
  });
}
