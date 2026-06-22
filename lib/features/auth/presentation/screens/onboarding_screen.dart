// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/life_state.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/network/api_client.dart';
import '../widgets/keza_primary_button.dart';

/// Onboarding screen — user selects their current life state.
/// This drives KezaIO's entire behaviour and module emphasis.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  LifeState? _selected;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _continue() async {
    if (_selected == null) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ApiClient.instance.post(
        '/auth/onboarding/complete/',
        data: {'life_state': _selected!.key},
      );
      if (!mounted) return;
      context.go(AppRoutes.home);
    } on DioException catch (_) {
      setState(() {
        _errorMessage = "Couldn't save that. Check your connection and try again.";
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const _OnboardingHeader(),
              const SizedBox(height: 24),
              if (_errorMessage != null) ...[
                _ErrorBanner(message: _errorMessage!),
                const SizedBox(height: 12),
              ],
              Expanded(
                child: ListView(
                  children: LifeState.values.map((state) {
                    return _LifeStateCard(
                      state: state,
                      isSelected: _selected == state,
                      onTap: () => setState(() => _selected = state),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              KezaPrimaryButton(
                label: 'Enter my space',
                isLoading: _isLoading,
                onPressed: _selected != null ? _continue : null,
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'You can change this anytime in settings.',
                  style: TextStyle(
                    color: AppColors.midnightTextMuted,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.danger.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.danger,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.danger, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingHeader extends StatelessWidget {
  const _OnboardingHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What season of life\nare you in right now?',
          style: TextStyle(
            color: AppColors.midnightTextPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'KezaIO adapts to where you are — not where you think you should be.',
          style: TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _LifeStateCard extends StatelessWidget {
  const _LifeStateCard({
    required this.state,
    required this.isSelected,
    required this.onTap,
  });

  final LifeState state;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.midnightGold.withOpacity(0.08)
              : AppColors.midnightSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.midnightGold
                : AppColors.midnightTextMuted.withOpacity(0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              state.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.label,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.midnightGold
                          : AppColors.midnightTextPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.description,
                    style: const TextStyle(
                      color: AppColors.midnightTextMuted,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.midnightGold,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
