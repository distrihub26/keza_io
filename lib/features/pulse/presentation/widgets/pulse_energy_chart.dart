// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Weekly energy bar chart for the Pulse module.
class PulseEnergyChart extends StatelessWidget {
  const PulseEnergyChart({super.key});

  @override
  Widget build(BuildContext context) {
    const data = [
      _DayData(day: 'Mon', energy: 3, mood: '😊'),
      _DayData(day: 'Tue', energy: 5, mood: '🔥'),
      _DayData(day: 'Wed', energy: 4, mood: '😊'),
      _DayData(day: 'Thu', energy: 2, mood: '😔'),
      _DayData(day: 'Fri', energy: 4, mood: '😊'),
      _DayData(day: 'Sat', energy: 0, mood: ''),
      _DayData(day: 'Sun', energy: 0, mood: ''),
    ];

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
          const Text(
            'Energy levels',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: data.map((d) => _EnergyBar(data: d)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayData {
  const _DayData({
    required this.day,
    required this.energy,
    required this.mood,
  });

  final String day;
  final int energy;
  final String mood;
}

class _EnergyBar extends StatelessWidget {
  const _EnergyBar({required this.data});

  final _DayData data;

  @override
  Widget build(BuildContext context) {
    final hasData = data.energy > 0;
    final barHeight = hasData ? (data.energy / 5) * 70.0 : 8.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasData)
          Text(data.mood, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 28,
          height: barHeight,
          decoration: BoxDecoration(
            color: hasData
                ? AppColors.modulePulse.withOpacity(0.6 + (data.energy / 5) * 0.4)
                : AppColors.midnightTextMuted.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data.day,
          style: const TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
