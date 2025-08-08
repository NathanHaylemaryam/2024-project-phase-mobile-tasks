import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/auth-response.dart';
import '../entity/user.dart';
import '../repository/repository.dart';

class SignUp implements UseCase<AuthResponse, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, AuthResponse>> call(SignUpParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }


}

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}