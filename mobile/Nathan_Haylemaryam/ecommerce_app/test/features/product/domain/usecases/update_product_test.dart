import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:your_app/features/product/domain/entities/product.dart';
import 'package:your_app/features/product/domain/usecases/update_product.dart';
import 'package:your_app/features/product/domain/repositories/product_repository.dart';
import 'package:your_app/core/error/failure.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late UpdateProduct usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = UpdateProduct(mockRepository);
  });

  final updatedProduct = Product(
    id: '1',
    name: 'Shoes (Updated)',
    description: 'Updated description',
    price: 79.99,
    imageUrl: 'https://example.com/shoes.jpg',
  );

  test('should update product using repository', () async {
    when(mockRepository.updateProduct(updatedProduct)).thenAnswer((_) async => Right(null));

    final result = await usecase(updatedProduct);

    expect(result, const Right(null));
    verify(mockRepository.updateProduct(updatedProduct));
    verifyNoMoreInteractions(mockRepository);
  });
}
