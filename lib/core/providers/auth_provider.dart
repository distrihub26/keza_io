// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../../features/auth/domain/models/keza_user.dart';

/// Provides the current authenticated user or null if not logged in.
final authProvider = FutureProvider<KezaUser?>((ref) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: AppConstants.keyAccessToken);
  if (token == null) return null;

  final userId = await storage.read(key: AppConstants.keyUserId);
  final lifeStateKey = await storage.read(key: AppConstants.keyLifeState);
  final onboarded = await storage.read(key: AppConstants.keyOnboarded);

  if (userId == null) return null;

  return KezaUser(
    id: userId,
    lifeStateKey: lifeStateKey,
    isOnboarded: onboarded == 'true',
  );
});

/// Clears all stored auth credentials — used on logout.
Future<void> clearAuthStorage() async {
  const storage = FlutterSecureStorage();
  await storage.delete(key: AppConstants.keyAccessToken);
  await storage.delete(key: AppConstants.keyRefreshToken);
  await storage.delete(key: AppConstants.keyUserId);
  await storage.delete(key: AppConstants.keyLifeState);
  await storage.delete(key: AppConstants.keyOnboarded);
}
