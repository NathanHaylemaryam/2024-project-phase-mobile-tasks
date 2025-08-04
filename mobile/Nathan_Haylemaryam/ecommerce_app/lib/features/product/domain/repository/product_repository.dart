import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, Unit>> deleteProduct(String id);

  Future<Either<Failure, Product>> getProduct(String id);

  Future<Either<Failure, List<Product>>> getAllProducts();


}
