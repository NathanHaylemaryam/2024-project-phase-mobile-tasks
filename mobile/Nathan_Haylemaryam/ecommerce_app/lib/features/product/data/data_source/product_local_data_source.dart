import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel> getLastCachedProduct();
}
