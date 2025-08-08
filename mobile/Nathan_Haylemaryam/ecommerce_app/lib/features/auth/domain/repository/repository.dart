import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/auth-response.dart';
import '../entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signup(String name, String email, String password);
  Future<Either<Failure, void>> logout();


}