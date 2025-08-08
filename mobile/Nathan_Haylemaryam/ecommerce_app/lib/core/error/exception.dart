// lib/core/error/exception.dart
import 'package:equatable/equatable.dart';

abstract class AppException implements Exception {}

class ServerException extends AppException with EquatableMixin {
  ServerException(String s);

  @override
  List<Object?> get props => [];

  String get message => '';
}

class CacheException extends AppException with EquatableMixin {
  @override
  List<Object?> get props => [];

  String get message => '';
}
class NotFoundException extends AppException with EquatableMixin {
  @override
  List<Object?> get props => [];
}
class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}
