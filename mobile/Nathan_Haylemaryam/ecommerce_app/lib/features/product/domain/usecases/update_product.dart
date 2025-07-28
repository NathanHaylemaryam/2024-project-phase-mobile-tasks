

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';


import '../entities/product.dart';
import '../repository/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Either<Failure, void>> call(Product product) {
    return repository.updateProduct(product);
  }
}
