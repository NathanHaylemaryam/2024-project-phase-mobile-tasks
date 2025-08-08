

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/repository.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,

    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    try {
      final userModel = await remoteDataSource.login(email, password);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String name, String email, String password) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }

    try {
      final userModel = await remoteDataSource.signup(name, email, password);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Signup failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Attempt remote logout if connected
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.logout();
        } catch (e) {
          // Proceed with local cleanup even if remote logout fails
          debugPrint('Remote logout failed: $e');
        }
      }


      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Logout failed: ${e.toString()}'));
    }
  }

  // @override
  // Future<Either<Failure, User>> getCurrentUser() async {
  //   try {
  //
  //     if (cachedUser != null) {
  //       // If connected, verify with server
  //       if (await networkInfo.isConnected) {
  //         try {
  //           final remoteUser = await remoteDataSource.getCurrentUser();
  //           // Update cache if user data changed
  //           if (remoteUser.id != cachedUser.id ||
  //               remoteUser.name != cachedUser.name ||
  //               remoteUser.email != cachedUser.email) {
  //             await localDataSource.cacheUser(remoteUser);
  //           }
  //           return Right(remoteUser.toEntity());
  //         } catch (e) {
  //           // If remote fails but we have cached user, return cached
  //           return Right(cachedUser.toEntity());
  //         }
  //       }
  //       return Right(cachedUser.toEntity());
  //     }
  //
  //     // If no cached user but connected, try remote
  //     if (await networkInfo.isConnected) {
  //       final remoteUser = await remoteDataSource.getCurrentUser();
  //       await localDataSource.cacheUser(remoteUser);
  //       return Right(remoteUser.toEntity());
  //     }
  //
  //     return Left(CacheFailure('No user data available'));
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message));
  //   } on CacheException catch (e) {
  //     return Left(CacheFailure(e.message));
  //   } on UnauthorizedException catch (e) {
  //     await localDataSource.clearAuthData();
  //     return Left(UnauthorizedFailure(e.message));
  //   } catch (e) {
  //     return Left(ServerFailure('Failed to get current user'));
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> isAuthenticated() async {
  //   try {
  //     final token = await localDataSource.getToken();
  //     if (token == null) return const Right(false);
  //
  //     // If we have a token, verify it with server if connected
  //     if (await networkInfo.isConnected) {
  //       try {
  //         await remoteDataSource.getCurrentUser();
  //         return const Right(true);
  //       } on UnauthorizedException {
  //         await localDataSource.clearAuthData();
  //         return const Right(false);
  //       } catch (e) {
  //         // If server check fails but we have token, assume valid
  //         return const Right(true);
  //       }
  //     }
  //
  //     // If offline but has token, assume authenticated
  //     return const Right(true);
  //   } catch (e) {
  //     return Left(CacheFailure('Failed to check authentication status'));
  //   }
  // }
}