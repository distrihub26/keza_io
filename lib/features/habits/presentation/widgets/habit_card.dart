// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays a single habit with completion toggle and streak.
class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.emoji,
    required this.name,
    required this.streak,
    required this.isCompleted,
    required this.frequency,
  });

  final String emoji;
  final String name;
  final int streak;
  final bool isCompleted;
  final String frequency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isCompleted
              ? AppColors.success.withOpacity(0.3)
              : AppColors.midnightTextMuted.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: isCompleted
                        ? AppColors.midnightTextMuted
                        : AppColors.midnightTextPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      frequency,
                      style: const TextStyle(
                        color: AppColors.midnightTextMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '·',
                      style: TextStyle(
                        color: AppColors.midnightTextMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '🔥 $streak day streak',
                      style: const TextStyle(
                        color: AppColors.midnightTextMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _CompletionButton(isCompleted: isCompleted),
        ],
      ),
    );
  }
}

class _CompletionButton extends StatelessWidget {
  const _CompletionButton({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.success
            : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCompleted
              ? AppColors.success
              : AppColors.midnightTextMuted.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 16,
            )
          : null,
    );
  }
}
