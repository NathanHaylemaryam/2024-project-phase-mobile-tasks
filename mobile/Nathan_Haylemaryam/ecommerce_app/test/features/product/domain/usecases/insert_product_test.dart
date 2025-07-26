import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:your_app/features/product/domain/entities/product.dart';
import 'package:your_app/features/product/domain/usecases/insert_product.dart';
import 'package:your_app/features/product/domain/repositories/product_repository.dart';
import 'package:your_app/core/error/failure.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late InsertProduct usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = InsertProduct(mockRepository);
  });

  final testProduct = Product(
    id: '123',
    name: 'Shoes',
    description: 'Sport shoes',
    price: 99.99,
    imageUrl: 'https://example.com/image.jpg',
  );

  test('should insert product using the repository', () async {
    // arrange
    when(mockRepository.insertProduct(testProduct))
        .thenAnswer((_) async => const Right(null));

    // act
    final result = await usecase(testProduct);

    // assert
    expect(result, const Right(null));
    verify(mockRepository.insertProduct(testProduct));
    verifyNoMoreInteractions(mockRepository);
  });
}
