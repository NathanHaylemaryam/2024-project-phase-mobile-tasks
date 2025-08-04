
import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/features/product/data/data_source/product_remote_data_source_impl.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([http.Client, SharedPreferences])
import 'product_remote_data_source_impl_test.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  final tProductModel = const ProductModel(
    id: 1,
    name: 'Test Product',
    decscription: 'Test Description',
    price: '100',
    imagepath: 'test.jpg',
  );

  final tProductList = [tProductModel];
  final tProductJson = tProductModel.toJson();
  final tProductListJson = [tProductJson];

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllProducts', () {
    test('should return list of products when successful', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(json.encode(tProductListJson), 200),
      );

      // act
      final result = await dataSource.getAllProducts();

      // assert
      expect(result, equals(tProductList));
    });

    test('should throw ServerException when response is unsuccessful', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response('Error', 500),
      );

      // act
      final call = dataSource.getAllProducts;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getProduct', () {
    test('should return product when successful (200)', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response(json.encode(tProductJson), 200),
      );

      // act
      final result = await dataSource.getProduct('1');

      // assert
      expect(result, equals(tProductModel));
    });

    test('should throw NotFoundException when product not found (404)', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response('Not Found', 404),
      );

      // act
      final call = dataSource.getProduct;

      // assert
      expect(() => call('1'), throwsA(isA<NotFoundException>()));
    });

    test('should throw ServerException on server error (500)', () async {
      // arrange
      when(mockHttpClient.get(any)).thenAnswer(
            (_) async => http.Response('Server Error', 500),
      );

      // act
      final call = dataSource.getProduct;

      // assert
      expect(() => call('1'), throwsA(isA<ServerException>()));
    });
  });

  // Similar test groups for insertProduct, updateProduct, deleteProduct
}