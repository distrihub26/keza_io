// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Daily check-in card for mood, energy and sleep logging.
class PulseCheckInCard extends StatefulWidget {
  const PulseCheckInCard({super.key});

  @override
  State<PulseCheckInCard> createState() => _PulseCheckInCardState();
}

class _PulseCheckInCardState extends State<PulseCheckInCard> {
  String? _selectedMood;
  int _energy = 3;
  int _sleep = 3;
  bool _saved = false;

  static const List<String> _moods = ['😫', '😔', '😐', '😊', '🔥'];

  Future<void> _save() async {
    if (_selectedMood == null) return;
    setState(() => _saved = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _saved = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.modulePulse.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Today\'s check-in',
                style: TextStyle(
                  color: AppColors.midnightTextPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                '30 sec',
                style: TextStyle(
                  color: AppColors.midnightTextMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'How are you feeling?',
            style: TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _moods.map((mood) {
              final isSelected = _selectedMood == mood;
              return GestureDetector(
                onTap: () => setState(() => _selectedMood = mood),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.modulePulse.withOpacity(0.15)
                        : AppColors.midnightBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.modulePulse
                          : AppColors.midnightTextMuted.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    mood,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          _SliderRow(
            label: 'Energy',
            value: _energy,
            onChanged: (v) => setState(() => _energy = v),
            activeColor: AppColors.moduleGoals,
          ),
          const SizedBox(height: 12),
          _SliderRow(
            label: 'Sleep quality',
            value: _sleep,
            onChanged: (v) => setState(() => _sleep = v),
            activeColor: AppColors.moduleClarity,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: _selectedMood != null ? _save : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.modulePulse,
                foregroundColor: Colors.white,
                disabledBackgroundColor:
                    AppColors.modulePulse.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _saved
                  ? const Icon(Icons.check_rounded, size: 20)
                  : const Text(
                      'Log check-in',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  final String label;
  final int value;
  final void Function(int) onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: activeColor,
              inactiveTrackColor: activeColor.withOpacity(0.15),
              thumbColor: activeColor,
              overlayColor: activeColor.withOpacity(0.1),
              trackHeight: 3,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
        ),
        SizedBox(
          width: 24,
          child: Text(
            '$value',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
