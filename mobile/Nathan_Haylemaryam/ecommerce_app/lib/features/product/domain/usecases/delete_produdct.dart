



import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Failure, Unit>>? call(int id) {
    return repository.deleteProduct(id);
  }
}
