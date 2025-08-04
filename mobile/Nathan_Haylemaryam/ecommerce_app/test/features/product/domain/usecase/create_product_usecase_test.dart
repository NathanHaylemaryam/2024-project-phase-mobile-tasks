import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/insert_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../presentation/product_bloc_test.mocks.dart';
@GenerateMocks([ProductRepository])
void main() {
  late InsertProduct usecase;
  late MockProductRepository mockRepository;
  const testProduct = Product(
    id: 1,
    name: 'Test Product',
    price: '100.0',
    decscription: 'Test Description',
    imagepath: 'test.jpg',
  );

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = InsertProduct(mockRepository);
  });

  // Assuming your use case takes Product directly
  test('should return Right(unit) on success', () async {
    // Arrange
    when(mockRepository.insertProduct(testProduct))
        .thenAnswer((_) async => const Right(unit));

    // Act - Pass product directly
    final result = await usecase(testProduct);

    // Assert
    verify(mockRepository.insertProduct(testProduct));
    expect(result, const Right(unit));
  });

  test('should return ServerFailure on error', () async {
    // Arrange
    when(mockRepository.insertProduct(testProduct))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await usecase(testProduct);

    // Assert
    expect(result, Left(ServerFailure()));
  });
}