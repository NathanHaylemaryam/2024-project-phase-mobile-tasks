
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../utils/shoe_product.dart';
import '../repository/product_repository.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct(this.repository);

  Future<Either<Failure, void>> call(Product product) {
    return repository.insertProduct(product);
  }
}
