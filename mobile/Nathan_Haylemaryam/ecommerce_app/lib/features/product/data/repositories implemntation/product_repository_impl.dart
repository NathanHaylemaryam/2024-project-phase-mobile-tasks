import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../utils/shoe_product.dart';
import '../../domain/repository/product_repository.dart';
import '../data_source/product_local_data_source.dart';
import '../data_source/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository{
  late ProductLocalDataSource localDataSource;
  late ProductRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, Product>> getProduct(int id){
    // TODO: implement later
    throw UnimplementedError();
  }
  Future<Either<Failure, void>> insertProduct(Product product){
    // TODO: implement later
    throw UnimplementedError();
  }
  Future<Either<Failure, void>> updateProduct(Product product){
    throw UnimplementedError();
  }
  Future<Either<Failure,Unit>> deleteProduct(int id){
    // TODO: implement later
    throw UnimplementedError();
  }

}