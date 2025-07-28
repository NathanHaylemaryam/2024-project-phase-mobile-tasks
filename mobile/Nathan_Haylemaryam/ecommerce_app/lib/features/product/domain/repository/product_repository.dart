

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../utils/shoe_product.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> insertProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, Unit>> deleteProduct(int id);
  Future<Either<Failure, Product>> getProduct(int id);
}