// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_theme.dart';
import '../constants/app_constants.dart';

/// Notifier that manages the active KezaIO theme.
class ThemeNotifier extends StateNotifier<KezaTheme> {
  ThemeNotifier() : super(KezaTheme.midnight) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(AppConstants.keyTheme);
    if (saved != null) {
      state = KezaTheme.values.firstWhere(
        (t) => t.name == saved,
        orElse: () => KezaTheme.midnight,
      );
    }
  }

  Future<void> setTheme(KezaTheme theme) async {
    state = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyTheme, theme.name);
  }
}

/// Global theme provider.
final themeProvider = StateNotifierProvider<ThemeNotifier, KezaTheme>(
  (ref) => ThemeNotifier(),
);
