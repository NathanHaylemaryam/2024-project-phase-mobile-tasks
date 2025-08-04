import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel> getLastCachedProduct();
  Future<List<ProductModel>> getLastProductList(); // ✅ add this
  Future<void> deleteProduct(int id);


}
