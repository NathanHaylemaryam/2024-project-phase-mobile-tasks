import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user.dart';
import '../repository/repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);


}