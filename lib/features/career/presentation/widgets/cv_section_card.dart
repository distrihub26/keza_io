// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays a single editable section of the master CV profile.
class CvSectionCard extends StatelessWidget {
  const CvSectionCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.summary,
    required this.isComplete,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String summary;
  final bool isComplete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.midnightTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    summary,
                    style: const TextStyle(
                      color: AppColors.midnightTextMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isComplete
                  ? Icons.check_circle_rounded
                  : Icons.error_outline_rounded,
              color: isComplete
                  ? AppColors.success
                  : AppColors.warning,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.midnightTextMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
