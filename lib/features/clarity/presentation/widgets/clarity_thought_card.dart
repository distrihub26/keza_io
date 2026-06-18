// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Category of a captured thought in the Clarity module.
enum ClarityCategory { action, idea, worry, dream, reference }

/// A single captured thought in the Clarity second brain.
class ClarityThought {
  const ClarityThought({
    required this.text,
    required this.category,
    required this.createdAt,
  });

  final String text;
  final ClarityCategory category;
  final String createdAt;
}

/// Displays a single captured thought with category color coding.
class ClarityThoughtCard extends StatelessWidget {
  const ClarityThoughtCard({super.key, required this.thought});

  final ClarityThought thought;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _categoryColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: _categoryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thought.text,
                  style: const TextStyle(
                    color: AppColors.midnightTextPrimary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _CategoryBadge(
                      label: _categoryLabel,
                      color: _categoryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      thought.createdAt,
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
          const Icon(
            Icons.more_horiz_rounded,
            color: AppColors.midnightTextMuted,
            size: 18,
          ),
        ],
      ),
    );
  }

  Color get _categoryColor {
    switch (thought.category) {
      case ClarityCategory.action:
        return AppColors.success;
      case ClarityCategory.idea:
        return AppColors.moduleClarity;
      case ClarityCategory.worry:
        return AppColors.danger;
      case ClarityCategory.dream:
        return AppColors.moduleGoals;
      case ClarityCategory.reference:
        return AppColors.info;
    }
  }

  String get _categoryLabel {
    switch (thought.category) {
      case ClarityCategory.action:
        return 'Action';
      case ClarityCategory.idea:
        return 'Idea';
      case ClarityCategory.worry:
        return 'Worry';
      case ClarityCategory.dream:
        return 'Dream';
      case ClarityCategory.reference:
        return 'Reference';
    }
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
