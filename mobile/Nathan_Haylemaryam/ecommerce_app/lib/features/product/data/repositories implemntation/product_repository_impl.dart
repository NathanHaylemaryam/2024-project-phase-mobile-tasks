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

    final int parsedId = int.tryParse(id) ?? 0;

    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        await localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct.toEntity());
      } on ServerException {
        return const Left(ServerFailure());
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final cachedProduct = await localDataSource.getLastCachedProduct();
        return Right(cachedProduct.toEntity());
      } on CacheException {
        return const Left(CacheFailure());
      } catch (e) {
        return const Left(CacheFailure());
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
        return const Left(ServerFailure());
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
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
        return const Left(ServerFailure());
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure());
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    print('➡️ LoadAllProductEvent triggered');

    try {
      // ✅ Try loading from local cache first
      final localProducts = await localDataSource.getLastProductList();
      return Right(localProducts.map((model) => model.toEntity()).toList());
    } catch (e) {
      print('⚠️ Local load failed, using dummy data');

      // 🔄 Fallback to dummy data if local fails
      final dummyProducts = [
        const Product(id: 1, name: 'Dummy Shoe1', price: '578', decscription: 'vnuer' ,imagepath: 'lib/images/1.jpg'),
        const Product(id: 1, name: 'Dummy Shoe2', price: '578', decscription: 'vnuer' ,imagepath: 'lib/images/1.jpg'),
      ];
      return Right(dummyProducts);
    }
  }

}