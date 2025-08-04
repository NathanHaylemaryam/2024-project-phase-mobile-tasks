import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<void> insertProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProduct(String id);
  Future<List<ProductModel>> getAllProducts(); // Returns List
}
