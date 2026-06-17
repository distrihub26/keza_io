// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/journal/presentation/screens/journal_screen.dart';
import '../../features/habits/presentation/screens/habits_screen.dart';
import '../../features/career/presentation/screens/career_screen.dart';
import '../../features/clarity/presentation/screens/clarity_screen.dart';
import '../../features/pulse/presentation/screens/pulse_screen.dart';
import '../../features/goals/presentation/screens/goals_screen.dart';
import '../../features/email/presentation/screens/email_screen.dart';
import '../presentation/screens/home_screen.dart';

/// Route name constants.
class AppRoutes {
  AppRoutes._();

  static const String splash     = '/';
  static const String login      = '/login';
  static const String register   = '/register';
  static const String onboarding = '/onboarding';
  static const String home       = '/home';
  static const String journal    = '/journal';
  static const String habits     = '/habits';
  static const String career     = '/career';
  static const String clarity    = '/clarity';
  static const String pulse      = '/pulse';
  static const String goals      = '/goals';
  static const String email      = '/email';
}

/// Application router provider.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.journal,
        builder: (BuildContext context, GoRouterState state) =>
            const JournalScreen(),
      ),
      GoRoute(
        path: AppRoutes.habits,
        builder: (BuildContext context, GoRouterState state) =>
            const HabitsScreen(),
      ),
      GoRoute(
        path: AppRoutes.career,
        builder: (BuildContext context, GoRouterState state) =>
            const CareerScreen(),
      ),
      GoRoute(
        path: AppRoutes.clarity,
        builder: (BuildContext context, GoRouterState state) =>
            const ClarityScreen(),
      ),
      GoRoute(
        path: AppRoutes.pulse,
        builder: (BuildContext context, GoRouterState state) =>
            const PulseScreen(),
      ),
      GoRoute(
        path: AppRoutes.goals,
        builder: (BuildContext context, GoRouterState state) =>
            const GoalsScreen(),
      ),
      GoRoute(
        path: AppRoutes.email,
        builder: (BuildContext context, GoRouterState state) =>
            const EmailScreen(),
      ),
    ],
  );
});
