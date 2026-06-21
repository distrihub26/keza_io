// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/app_constants.dart';
import '../domain/models/keza_user.dart';

/// Handles authentication API calls — login, register, logout.
class AuthRepository {
  AuthRepository();

  final Dio _dio = ApiClient.instance;
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Logs in with email and password. Returns the authenticated user.
  Future<KezaUser> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login/',
      data: {'email': email, 'password': password},
    );

    final data = response.data as Map<String, dynamic>;
    await _saveTokens(
      access: data['access'] as String,
      refresh: data['refresh'] as String,
    );

    final userJson = data['user'] as Map<String, dynamic>;
    final user = KezaUser.fromJson(userJson);
    await _saveUserMeta(user);
    return user;
  }

  /// Registers a new user. Returns the authenticated user.
  Future<KezaUser> register({
    required String email,
    required String username,
    required String password,
    String? firstName,
  }) async {
    final response = await _dio.post(
      '/auth/register/',
      data: {
        'email': email,
        'username': username,
        'password': password,
        if (firstName != null) 'first_name': firstName,
      },
    );

    final data = response.data as Map<String, dynamic>;
    await _saveTokens(
      access: data['access'] as String,
      refresh: data['refresh'] as String,
    );

    final userJson = data['user'] as Map<String, dynamic>;
    final user = KezaUser.fromJson(userJson);
    await _saveUserMeta(user);
    return user;
  }

  Future<void> _saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: AppConstants.keyAccessToken, value: access);
    await _storage.write(key: AppConstants.keyRefreshToken, value: refresh);
  }

  Future<void> _saveUserMeta(KezaUser user) async {
    await _storage.write(key: AppConstants.keyUserId, value: user.id);
    await _storage.write(
      key: AppConstants.keyLifeState,
      value: user.lifeStateKey ?? '',
    );
    await _storage.write(
      key: AppConstants.keyOnboarded,
      value: user.isOnboarded.toString(),
    );
  }

  /// Logs out — clears all stored tokens and user metadata.
  Future<void> logout() async {
    await _storage.delete(key: AppConstants.keyAccessToken);
    await _storage.delete(key: AppConstants.keyRefreshToken);
    await _storage.delete(key: AppConstants.keyUserId);
    await _storage.delete(key: AppConstants.keyLifeState);
    await _storage.delete(key: AppConstants.keyOnboarded);
  }
}
