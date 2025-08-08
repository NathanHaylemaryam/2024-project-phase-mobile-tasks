// lib/core/error/failure.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = '']);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = '']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = '']) : super(message);
}
class InvalidNameFailure extends Failure {}

class InvalidPriceFailure extends Failure {}

class InvalidDescriptionFailure extends Failure {}

class InvalidImageFailure extends Failure {}
class NetworkFailure extends Failure {
  NetworkFailure(String s);
}
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(String message) : super(message);
}