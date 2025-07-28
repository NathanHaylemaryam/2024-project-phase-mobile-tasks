// product_repository_impl.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_local_data_source.dart';
import '../data_source/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        await localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cachedProduct = await localDataSource.getLastCachedProduct();
        return Right(cachedProduct.toEntity());
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.updateProduct(model);
        await localDataSource.cacheProduct(model);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> insertProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final model = ProductModel.fromEntity(product);
        await remoteDataSource.insertProduct(model);
        await localDataSource.cacheProduct(model);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}