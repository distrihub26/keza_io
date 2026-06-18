// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Shows the user's current life state in the career module.
class CareerLifeStateBanner extends StatelessWidget {
  const CareerLifeStateBanner({
    super.key,
    required this.lifeState,
    required this.emoji,
  });

  final String lifeState;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.moduleCareer.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.moduleCareer.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lifeState,
                  style: const TextStyle(
                    color: AppColors.moduleCareer,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Daily job matches · follow-up reminders active',
                  style: TextStyle(
                    color: AppColors.midnightTextMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.tune_rounded,
            color: AppColors.midnightTextMuted,
            size: 18,
          ),
        ],
      ),
    );
  }
}
