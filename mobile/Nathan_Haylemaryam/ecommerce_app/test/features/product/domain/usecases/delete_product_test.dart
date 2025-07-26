import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:your_app/features/product/domain/usecases/delete_product.dart';
import 'package:your_app/features/product/domain/repositories/product_repository.dart';
import 'package:your_app/core/error/failure.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late DeleteProduct usecase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = DeleteProduct(mockRepository);
  });

  const productId = '1';

  test('should delete product using repository', () async {
    when(mockRepository.deleteProduct(productId)).thenAnswer((_) async => Right(null));

    final result = await usecase(productId);

    expect(result, const Right(null));
    verify(mockRepository.deleteProduct(productId));
    verifyNoMoreInteractions(mockRepository);
  });
}
