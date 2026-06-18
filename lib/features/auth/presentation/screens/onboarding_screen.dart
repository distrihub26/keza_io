// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/life_state.dart';
import '../../../../core/router/app_router.dart';
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

  Future<void> _continue() async {
    if (_selected == null) return;
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.home);
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
              const SizedBox(height: 36),
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
