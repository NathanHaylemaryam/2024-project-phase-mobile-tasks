// lib/features/auth/domain/entities/auth_response.dart
import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResponse extends Equatable {
  final User user;
  final String token;

  const AuthResponse({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}