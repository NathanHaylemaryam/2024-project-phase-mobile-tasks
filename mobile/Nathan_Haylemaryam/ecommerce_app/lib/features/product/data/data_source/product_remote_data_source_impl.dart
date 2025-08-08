
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://g5-flutter-learning-path-be-tvum.onrender.com/api/v1/products';
  static const String _productsEndpoint = '/products';
  static const int _timeoutSeconds = 30;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {

      print('hi');
      final response = await client
          .get(Uri.parse('$_baseUrl'));
      print('ghh${response.statusCode}');
      return _handleResponse(response);

  }

  @override
  // In your ProductRemoteDataSourceImpl.dart
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(
      Uri.parse('$_baseUrl/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException('servererror');
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
          print(response);
      _handleResponse(response);
    } catch (e) {
      throw ServerException('servererror');
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
      throw ServerException('servererror');
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
      throw ServerException('servererror');
    }
  }

  List<ProductModel> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body)['data'] ;

      var temp_res = responseData.map((model) => ProductModel.fromJson(model)).toList();
      print(temp_res);
      return temp_res;

    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException('servererror');
    }
  }
}