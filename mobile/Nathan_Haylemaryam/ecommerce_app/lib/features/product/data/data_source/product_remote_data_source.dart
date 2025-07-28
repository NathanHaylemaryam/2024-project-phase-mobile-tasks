import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getAllProducts();
}
