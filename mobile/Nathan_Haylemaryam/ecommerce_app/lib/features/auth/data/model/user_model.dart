// lib/features/auth/data/models/user_model.dart

import '../../domain/entity/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'token': token,
  };

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      token: token,
    );
  }

  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      token: entity.token,
    );
  }
}