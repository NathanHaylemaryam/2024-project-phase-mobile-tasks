import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:your_app/features/product/domain/entities/product.dart';
import 'package:your_app/features/product/domain/usecases/get_product.dart';
import 'package:your_app/features/product/domain/repositories/product_repository.dart';
import 'package:your_app/core/error/failure.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProduct usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProduct(mockRepository);
  });

  const productId = '1';
  final testProduct = Product(
    id: productId,
    name: 'Laptop',
    description: 'Gaming Laptop',
    price: 1499.99,
    imageUrl: 'https://example.com/laptop.jpg',
  );

  test('should get product using repository', () async {
    when(mockRepository.getProduct(productId)).thenAnswer((_) async => Right(testProduct));

    final result = await usecase(productId);

    expect(result, Right(testProduct));
    verify(mockRepository.getProduct(productId));
    verifyNoMoreInteractions(mockRepository);
  });
}
