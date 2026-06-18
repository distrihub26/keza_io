// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Displays an AI-generated personal insight on the home screen.
class KezaInsightCard extends StatelessWidget {
  const KezaInsightCard({
    super.key,
    required this.insight,
    required this.label,
  });

  final String insight;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightBackground,
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(
            color: AppColors.midnightGold,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$insight"',
            style: const TextStyle(
              color: AppColors.midnightGoldLight,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
