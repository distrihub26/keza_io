// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

/// Global application constants for KezaIO.
class AppConstants {
  AppConstants._();

  static const String appName = 'KezaIO';
  static const String appTagline = 'Your private AI life advisor';
  static const String companyName = 'Jiamini Innovations Ltd';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.keza.io/v1',
  );
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyLifeState = 'life_state';
  static const String keyTheme = 'app_theme';
  static const String keyOnboarded = 'is_onboarded';

  // Free tier limits
  static const int freeTailoredCvsPerMonth = 3;
  static const int freeAiInteractionsPerMonth = 10;
  static const int freeDocumentStorageLimit = 3;
  static const int freeApplicationHistoryLimit = 5;

  // Pagination
  static const int defaultPageSize = 20;
}
