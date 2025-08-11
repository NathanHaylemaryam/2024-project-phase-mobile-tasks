import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';
import '../model/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String name, String email, String password);
  Future<void> logout();
}
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio {
    // Configure Dio for HTTPS
    _dio.options
      ..baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v2' // Use your actual HTTPS endpoint
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {'Content-Type': 'application/json'};
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/login',
        data: {'email': email, 'password': password},
        options: Options(validateStatus: (status) => true),
      );
      final token = response.data['data']['access_token'] as String;
      if (token == null) {
        throw UnauthorizedException('No authentication token found');
      }

      final response_new = await _dio.get(
        'users/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => true,
        ),
      );

      return UserModel.fromJson(response_new.data['data']);



    } on DioException catch (e) {
      throw _handleDioError(e, 'Login failed');
    }
  }

  @override
  Future<UserModel> signup(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        'auth/signup',
        data: {'name': name, 'email': email, 'password': password},
        options: Options(validateStatus: (status) => true),
      );

      return UserModel.fromJson(response.data['data']);

    } on DioException catch (e) {
      throw _handleDioError(e, 'Signup failed');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post(
        'auth/logout',
        options: Options(
          headers: await _getAuthHeader(),
          validateStatus: (status) => true,
        ),
      );
    } on DioException catch (e) {
      throw _handleDioError(e, 'Logout failed');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _dio.get(
        'auth/me',
        options: Options(
          headers: await _getAuthHeader(),
          validateStatus: (status) => true,
        ),
      );

      return _handleUserResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Failed to fetch user');
    }
  }

  // Helper Methods

  UserModel(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel(response).fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Invalid credentials');
    } else if (response.statusCode == 400) {
      throw ServerException(response.data['message'] ?? 'Bad request');
    } else {
      throw ServerException('Request failed with status ${response.statusCode}');
    }
  }

  UserModel _handleUserResponse(Response response) {
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Session expired');
    } else {
      throw ServerException('Failed to fetch user data');
    }
  }

  Future<Map<String, String>> _getAuthHeader() async {
    // In a real app, you'd get this from your local storage
    final token = await _getCachedToken();
    return {'Authorization': 'Bearer $token'};
  }

  Future<String> _getCachedToken() async {
    // Implement your token retrieval logic
    // This would typically come from your AuthLocalDataSource
    throw UnimplementedError('Token retrieval not implemented');
  }

  Exception _handleDioError(DioException e, String defaultMessage) {
    if (e.response?.statusCode == 401) {
      return UnauthorizedException(
        e.response?.data['message'] ?? 'Unauthorized access',
      );
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return ServerException('Connection timeout');
    } else if (e.type == DioExceptionType.badResponse) {
      return ServerException(
        e.response?.data['message'] ?? 'Invalid server response',
      );
    } else {
      return ServerException(defaultMessage);
    }
  }
}