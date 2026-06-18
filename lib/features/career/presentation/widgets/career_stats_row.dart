// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays application pipeline stats in the career module.
class CareerStatsRow extends StatelessWidget {
  const CareerStatsRow({
    super.key,
    required this.applied,
    required this.inReview,
    required this.interviews,
    required this.responseRate,
  });

  final int applied;
  final int inReview;
  final int interviews;
  final int responseRate;

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(value: '$applied', label: 'Applied'),
          _Divider(),
          _StatItem(value: '$inReview', label: 'In review'),
          _Divider(),
          _StatItem(value: '$interviews', label: 'Interviews'),
          _Divider(),
          _StatItem(value: '$responseRate%', label: 'Response'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.moduleCareer,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      color: AppColors.midnightTextMuted.withOpacity(0.2),
    );
  }
}
