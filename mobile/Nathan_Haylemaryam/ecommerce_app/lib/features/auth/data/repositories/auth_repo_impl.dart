
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/auth-response.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;


  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel.toEntity()); // Convert to entity
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String name, String email, String password) async {
    try {
      final authResponseModel = await remoteDataSource.signup(name, email, password);
      return Right(authResponseModel.toEntity()); // Convert to entity
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }





  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // 1. Attempt remote logout if possible
      try {
        await remoteDataSource.logout();
      } catch (e) {
        // Even if remote logout fails, proceed with local cleanup
        print('Remote logout failed: $e');
      }

      // 2. Clear local authentication data


      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Logout failed: ${e.toString()}'));
    }
  }}