// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays a single journal entry preview card.
class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({
    super.key,
    required this.date,
    required this.preview,
    required this.mood,
    required this.wordCount,
  });

  final String date;
  final String preview;
  final String mood;
  final int wordCount;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.midnightTextMuted,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Text(mood, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    '$wordCount words',
                    style: const TextStyle(
                      color: AppColors.midnightTextMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            preview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
