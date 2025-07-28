

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<Either<Failure, Product>> call(String id) {
    return repository.getProduct(id);
  }
}
