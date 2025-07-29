// lib/features/product/data/data_source/product_remote_data_source_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://your-api-base-url.com/api';
  static const String _productsEndpoint = '/products';
  static const int _timeoutSeconds = 30;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client
          .get(Uri.parse('$_baseUrl$_productsEndpoint'))
          .timeout(const Duration(seconds: _timeoutSeconds));

      return _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    try {
      final response = await client
          .get(Uri.parse('$_baseUrl$_productsEndpoint/$id'))
          .timeout(const Duration(seconds: _timeoutSeconds));

      final products = _handleResponse(response);
      if (products.isEmpty) throw NotFoundException();
      return products.first;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    try {
      final response = await client
          .post(
        Uri.parse('$_baseUrl$_productsEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      )
          .timeout(const Duration(seconds: _timeoutSeconds));

      _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await client
          .put(
        Uri.parse('$_baseUrl$_productsEndpoint/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      )
          .timeout(const Duration(seconds: _timeoutSeconds));

      _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await client
          .delete(Uri.parse('$_baseUrl$_productsEndpoint/$id'))
          .timeout(const Duration(seconds: _timeoutSeconds));

      _handleResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  List<ProductModel> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException();
    }
  }
}