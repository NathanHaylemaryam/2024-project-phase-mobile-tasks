// lib/core/error/exception.dart
import 'package:equatable/equatable.dart';

abstract class AppException implements Exception {}

class ServerException extends AppException with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CacheException extends AppException with EquatableMixin {
  @override
  List<Object?> get props => [];
}
class NotFoundException extends AppException with EquatableMixin {
  @override
  List<Object?> get props => [];
}
