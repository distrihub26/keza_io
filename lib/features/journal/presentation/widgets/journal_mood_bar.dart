// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Weekly mood summary bar shown at the top of the journal screen.
class JournalMoodBar extends StatelessWidget {
  const JournalMoodBar({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This week',
            style: TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DayMood(day: 'Mon', mood: '😊', hasEntry: true),
              _DayMood(day: 'Tue', mood: '😔', hasEntry: true),
              _DayMood(day: 'Wed', mood: '🤔', hasEntry: true),
              _DayMood(day: 'Thu', mood: '😌', hasEntry: true),
              _DayMood(day: 'Fri', mood: '😊', hasEntry: true),
              _DayMood(day: 'Sat', mood: '', hasEntry: false),
              _DayMood(day: 'Sun', mood: '', hasEntry: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayMood extends StatelessWidget {
  const _DayMood({
    required this.day,
    required this.mood,
    required this.hasEntry,
  });

  final String day;
  final String mood;
  final bool hasEntry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hasEntry
            ? Text(mood, style: const TextStyle(fontSize: 20))
            : Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.midnightTextMuted.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.midnightTextMuted.withOpacity(0.2),
                  ),
                ),
              ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
            color: hasEntry
                ? AppColors.midnightTextPrimary
                : AppColors.midnightTextMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
