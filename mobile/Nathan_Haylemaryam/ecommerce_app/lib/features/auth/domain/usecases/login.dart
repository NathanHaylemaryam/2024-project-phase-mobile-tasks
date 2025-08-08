import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/auth-response.dart';
import '../entity/user.dart';
import '../repository/repository.dart';

class Login implements UseCase<AuthResponse, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(LoginParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}