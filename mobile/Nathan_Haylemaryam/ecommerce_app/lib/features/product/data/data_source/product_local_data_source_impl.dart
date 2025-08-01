// lib/features/product/data/data_source/product_local_data_source_impl.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';
import 'product_local_data_source.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cachedProductsKey = 'CACHED_PRODUCTS';
  static const String _lastCachedProductKey = 'LAST_CACHED_PRODUCT';




  ProductLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheProduct(ProductModel product) async {
    // Cache single product
    await sharedPreferences.setString(
      _lastCachedProductKey,
      json.encode(product.toJson()),
    );

    // Also add to products list
    final cachedProducts = await getLastProductList();
    cachedProducts.add(product);
    await _cacheProductList(cachedProducts);
  }

  @override
  Future<ProductModel> getLastCachedProduct() async {
    final jsonString = sharedPreferences.getString(_lastCachedProductKey);
    if (jsonString != null) {
      return ProductModel.fromJson(json.decode(jsonString));
    }
    throw CacheException();
  }

  @override
  Future<List<ProductModel>> getLastProductList() async {
    final jsonString = sharedPreferences.getString(_cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> _cacheProductList(List<ProductModel> products) async {
    final jsonList = products.map((product) => product.toJson()).toList();
    await sharedPreferences.setString(
      _cachedProductsKey,
      json.encode(jsonList),
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    final products = await getLastProductList();
    products.removeWhere((product) => product.id == id);
    await _cacheProductList(products);
  }
}