// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Available KezaIO themes.
enum KezaTheme {
  midnight,
  forest,
  cloud,
  dusk,
  pureBlack,
}

/// Builds MaterialThemeData for each KezaIO theme.
class AppTheme {
  AppTheme._();

  static ThemeData getTheme(KezaTheme theme) {
    switch (theme) {
      case KezaTheme.forest:
        return _buildTheme(
          background: AppColors.forestBackground,
          surface: AppColors.forestSurface,
          accent: AppColors.forestAccent,
          accentLight: AppColors.forestAccentLight,
          textPrimary: AppColors.forestTextPrimary,
          textMuted: AppColors.forestTextMuted,
          brightness: Brightness.dark,
        );
      case KezaTheme.cloud:
        return _buildTheme(
          background: AppColors.cloudBackground,
          surface: AppColors.cloudSurface,
          accent: AppColors.cloudAccent,
          accentLight: AppColors.cloudAccentLight,
          textPrimary: AppColors.cloudTextPrimary,
          textMuted: AppColors.cloudTextMuted,
          brightness: Brightness.light,
        );
      case KezaTheme.dusk:
        return _buildTheme(
          background: AppColors.duskBackground,
          surface: AppColors.duskSurface,
          accent: AppColors.duskAccent,
          accentLight: AppColors.duskAccentLight,
          textPrimary: AppColors.duskTextPrimary,
          textMuted: AppColors.duskTextMuted,
          brightness: Brightness.dark,
        );
      case KezaTheme.pureBlack:
        return _buildTheme(
          background: AppColors.blackBackground,
          surface: AppColors.blackSurface,
          accent: AppColors.blackAccent,
          accentLight: AppColors.blackAccentLight,
          textPrimary: AppColors.blackTextPrimary,
          textMuted: AppColors.blackTextMuted,
          brightness: Brightness.dark,
        );
      case KezaTheme.midnight:
        return _buildTheme(
          background: AppColors.midnightBackground,
          surface: AppColors.midnightSurface,
          accent: AppColors.midnightGold,
          accentLight: AppColors.midnightGoldLight,
          textPrimary: AppColors.midnightTextPrimary,
          textMuted: AppColors.midnightTextMuted,
          brightness: Brightness.dark,
        );
    }
  }

  static ThemeData _buildTheme({
    required Color background,
    required Color surface,
    required Color accent,
    required Color accentLight,
    required Color textPrimary,
    required Color textMuted,
    required Brightness brightness,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: background,
        secondary: accentLight,
        onSecondary: background,
        error: AppColors.danger,
        onError: Colors.white,
        surface: surface,
        onSurface: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: textPrimary, fontSize: 14),
        bodySmall: TextStyle(color: textMuted, fontSize: 12),
        labelSmall: TextStyle(color: textMuted, fontSize: 11),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: textMuted.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: textMuted.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accent),
        ),
      ),
      useMaterial3: true,
    );
  }
}
