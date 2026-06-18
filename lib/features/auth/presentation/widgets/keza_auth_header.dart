// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Reusable auth screen header with title and subtitle.
class KezaAuthHeader extends StatelessWidget {
  const KezaAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.midnightSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.midnightGold,
              width: 1.5,
            ),
          ),
          child: const Center(
            child: Text(
              '✦',
              style: TextStyle(
                color: AppColors.midnightGold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.midnightTextPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
