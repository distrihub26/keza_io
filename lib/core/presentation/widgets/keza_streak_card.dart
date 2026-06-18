// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Displays the user's current journaling streak on the home screen.
class KezaStreakCard extends StatelessWidget {
  const KezaStreakCard({
    super.key,
    required this.streakDays,
    required this.bestStreak,
    required this.weekLog,
  });

  final int streakDays;
  final int bestStreak;
  final List<bool> weekLog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.midnightTextMuted.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          _StreakNumber(days: streakDays),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Day streak',
                  style: TextStyle(
                    color: AppColors.midnightTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Keep going — your best is $bestStreak',
                  style: const TextStyle(
                    color: AppColors.midnightTextMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                _WeekDots(weekLog: weekLog),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakNumber extends StatelessWidget {
  const _StreakNumber({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$days',
      style: const TextStyle(
        color: AppColors.midnightGold,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        height: 1,
      ),
    );
  }
}

class _WeekDots extends StatelessWidget {
  const _WeekDots({required this.weekLog});

  final List<bool> weekLog;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: weekLog.map((active) {
        return Container(
          width: 22,
          height: 5,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: active
                ? AppColors.midnightGold
                : AppColors.midnightTextMuted.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }).toList(),
    );
  }
}
