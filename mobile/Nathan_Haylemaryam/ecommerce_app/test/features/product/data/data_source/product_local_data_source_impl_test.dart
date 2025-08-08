// test/features/product/data/data_source/product_local_data_source_impl_test.dart
import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/data_source/product_local_data_source_impl.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'product_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  final tProductModel = const ProductModel(
    id: '1',
    name: 'Test Product',
    decscription: 'Test Description',
    price: 100,
    imagepath: 'test.jpg',
  );

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('deleteProduct', () {
    test('should remove the product and update cache', () async {
      // arrange
      final productList = [tProductModel];
      final expectedJsonString = json.encode(
        productList.map((product) => product.toJson()).toList(),
      );
      when(mockSharedPreferences.getString(any))
          .thenReturn(expectedJsonString);
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      await dataSource.deleteProduct(tProductModel.id as int);

      // assert
      verify(mockSharedPreferences.setString(any, json.encode([])));
    });
  });
  group('getLastCachedProduct', () {
    test('should return Product from SharedPreferences when there is one', () async {
      // arrange
      final expectedJsonString = json.encode(tProductModel.toJson());
      when(mockSharedPreferences.getString(any))
          .thenReturn(expectedJsonString);

      // act
      final result = await dataSource.getLastCachedProduct();

      // assert
      verify(mockSharedPreferences.getString(any));
      expect(result, equals(tProductModel));
    });

    test('should throw CacheException when there is no cached data', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = dataSource.getLastCachedProduct;

      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('getLastProductList', () {
    test('should return list of Products from SharedPreferences', () async {
      // arrange
      final productList = [tProductModel];
      final expectedJsonString = json.encode(
        productList.map((product) => product.toJson()).toList(),
      );
      when(mockSharedPreferences.getString(any))
          .thenReturn(expectedJsonString);

      // act
      final result = await dataSource.getLastProductList();

      // assert
      verify(mockSharedPreferences.getString(any));
      expect(result, equals(productList));
    });

    test('should return empty list when there is no cached data', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      // act
      final result = await dataSource.getLastProductList();

      // assert
      expect(result, equals([]));
    });
  });
  group('cacheProduct', () {
    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null); // Stub getString
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      await dataSource.cacheProduct(tProductModel);

      // assert
      final expectedJsonString = json.encode(tProductModel.toJson());
      verify(mockSharedPreferences.setString(
        any,
        expectedJsonString,
      ));
      verify(mockSharedPreferences.getString(any)); // Verify getString was called
    });
  });






}