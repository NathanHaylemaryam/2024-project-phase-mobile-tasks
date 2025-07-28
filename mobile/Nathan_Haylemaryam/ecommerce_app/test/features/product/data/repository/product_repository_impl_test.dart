// product_repository_impl_test.dart
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/product/data/data_source/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/data_source/product_remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories%20implemntation/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}
class MockLocalDataSource extends Mock implements ProductLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProductModel = const ProductModel(
    id: 1,
    name: 'Test Product',
    decscription: 'Test Description',
    price: '100',
    imagepath: 'test.jpg',
  );

  final Product tProductEntity = tProductModel.toEntity();
  const String tId = '1';

  group('getProduct', () {
    test('should return remote data when call is successful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProduct(tId))
          .thenAnswer((_) async => tProductModel);
      when(mockLocalDataSource.cacheProduct(tProductModel))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.getProduct(tId);

      // assert
      verify(mockRemoteDataSource.getProduct(tId));
      verify(mockLocalDataSource.cacheProduct(tProductModel));
      expect(result, equals(Right(tProductEntity)));
    });

    test('should return cached data when no internet', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastCachedProduct())
          .thenAnswer((_) async => tProductModel);

      // act
      final result = await repository.getProduct(tId);

      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastCachedProduct());
      expect(result, equals(Right(tProductEntity)));
    });

    test('should return ServerFailure when remote fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProduct(tId))
          .thenThrow(ServerException());

      // act
      final result = await repository.getProduct(tId);

      // assert
      verify(mockRemoteDataSource.getProduct(tId));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return CacheFailure when cache fails', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getLastCachedProduct())
          .thenThrow(CacheException());

      // act
      final result = await repository.getProduct(tId);

      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getLastCachedProduct());
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('insertProduct', () {
    test('should insert product when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(tProductModel))
          .thenAnswer((_) async => Future.value());
      when(mockLocalDataSource.cacheProduct(tProductModel))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.insertProduct(tProductEntity);

      // assert
      verify(mockRemoteDataSource.insertProduct(tProductModel));
      verify(mockLocalDataSource.cacheProduct(tProductModel));
      expect(result, equals(const Right(null)));
    });

    test('should return ServerFailure when offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // act
      final result = await repository.insertProduct(tProductEntity);

      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('updateProduct', () {
    test('should update product when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateProduct(tProductModel))
          .thenAnswer((_) async => Future.value());
      when(mockLocalDataSource.cacheProduct(tProductModel))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.updateProduct(tProductEntity);

      // assert
      verify(mockRemoteDataSource.updateProduct(tProductModel));
      verify(mockLocalDataSource.cacheProduct(tProductModel));
      expect(result, equals(const Right(null)));
    });
  });

  group('deleteProduct', () {
    test('should delete product when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteProduct(tId))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.deleteProduct(tId);

      // assert
      verify(mockRemoteDataSource.deleteProduct(tId));
      expect(result, equals(const Right(unit)));
    });
  });
}