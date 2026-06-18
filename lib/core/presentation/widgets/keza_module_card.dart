// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Displays a single KezaIO module on the home screen grid.
class KezaModuleCard extends StatelessWidget {
  const KezaModuleCard({
    super.key,
    required this.emoji,
    required this.name,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
    this.isPremium = false,
  });

  final String emoji;
  final String name;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.midnightBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.midnightTextMuted.withOpacity(0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const Spacer(),
            Text(
              name,
              style: const TextStyle(
                color: AppColors.midnightTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.midnightTextMuted,
                fontSize: 11,
              ),
            ),
            if (isPremium) ...[
              const SizedBox(height: 6),
              _PremiumBadge(),
            ],
          ],
        ),
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.midnightGold.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.midnightGold.withOpacity(0.4),
        ),
      ),
      child: const Text(
        'Premium',
        style: TextStyle(
          color: AppColors.midnightGold,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
