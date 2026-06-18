// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays a single goal with progress bar and milestone count.
class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.category,
    required this.progress,
    required this.deadline,
    required this.milestones,
    required this.completed,
  });

  final String emoji;
  final String title;
  final String category;
  final double progress;
  final String deadline;
  final int milestones;
  final int completed;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.midnightTextPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        _CategoryChip(category: category),
                        const SizedBox(width: 8),
                        Text(
                          '· $deadline',
                          style: const TextStyle(
                            color: AppColors.midnightTextMuted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.moduleGoals,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _ProgressBar(progress: progress),
          const SizedBox(height: 10),
          Text(
            '$completed of $milestones milestones completed',
            style: const TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 6,
        backgroundColor: AppColors.moduleGoals.withOpacity(0.15),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.moduleGoals),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.moduleGoals.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: AppColors.moduleGoals,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
