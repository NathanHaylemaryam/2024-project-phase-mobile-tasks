import 'package:dartz/dartz.dart';

import '../../features/product/domain/entities/product.dart';
import '../error/failure.dart';

class ProductInputConverter {
  Either<Failure, Product> convertFormToProduct({
    required String name,
    required String description,
    required String priceStr,
    required String imagePath,
    required int id,
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

    double? price;
    try {
      price = double.parse(priceStr);
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
      price: price.toStringAsFixed(2),
      imagepath: imagePath.trim(),
    ));
  }
}
