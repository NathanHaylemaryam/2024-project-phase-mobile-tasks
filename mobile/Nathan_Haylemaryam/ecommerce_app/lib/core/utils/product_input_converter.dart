import 'package:dartz/dartz.dart';

import '../../features/product/domain/entities/product.dart';
import '../error/failure.dart';

class ProductInputConverter {
  Either<Failure, Product> convertFormToProduct({
    required String name,
    required String description,
    required int priceStr,
    required String imagePath,
    required String id,
  }) {
    if (name.trim().isEmpty) {
      return Left(InvalidNameFailure());
    }

    if (description.trim().isEmpty) {
      return Left(InvalidDescriptionFailure());
    }

    if (imagePath.trim().isEmpty) {
      return Left(InvalidImageFailure());
    }

    int? price;
    try {
      price = priceStr;
      if (price <= 0) {
        return Left(InvalidPriceFailure());
      }
    } catch (_) {
      return Left(InvalidPriceFailure());
    }

    return Right(Product(
      id: id,
      name: name.trim(),
      decscription: description.trim(),
      price: price,
      imagepath: imagePath.trim(),
    ));
  }
}
