// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../features/auth/presentation/widgets/keza_text_field.dart';
import '../../../../features/auth/presentation/widgets/keza_primary_button.dart';
import '../providers/habits_provider.dart';

/// Bottom sheet for adding a new habit.
class AddHabitSheet extends ConsumerStatefulWidget {
  const AddHabitSheet({super.key});

  @override
  ConsumerState<AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends ConsumerState<AddHabitSheet> {
  final _nameController = TextEditingController();
  String _selectedEmoji = '⭐';
  String _selectedFrequency = 'Daily';
  bool _isSaving = false;

  static const List<String> _emojis = [
    '⭐', '🏃', '📖', '💧', '🧘', '✍️', '💪',
    '🎯', '🥗', '😴', '🎵', '🌿', '💊', '🧠',
  ];

  static const List<String> _frequencies = [
    'Daily',
    '3x per week',
    'Weekdays',
    'Weekends',
    'Weekly',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    ref.read(habitsProvider.notifier).addHabit(
          emoji: _selectedEmoji,
          name: _nameController.text.trim(),
          frequency: _selectedFrequency,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SheetHandle(),
          const SizedBox(height: 20),
          const Text(
            'New habit',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          KezaTextField(
            controller: _nameController,
            label: 'Habit name',
            hint: 'e.g. Morning run',
          ),
          const SizedBox(height: 20),
          const Text(
            'Pick an emoji',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _EmojiPicker(
            emojis: _emojis,
            selected: _selectedEmoji,
            onSelect: (e) => setState(() => _selectedEmoji = e),
          ),
          const SizedBox(height: 20),
          const Text(
            'Frequency',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          _FrequencyPicker(
            frequencies: _frequencies,
            selected: _selectedFrequency,
            onSelect: (f) => setState(() => _selectedFrequency = f),
          ),
          const SizedBox(height: 24),
          KezaPrimaryButton(
            label: 'Add habit',
            isLoading: _isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.midnightTextMuted.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _EmojiPicker extends StatelessWidget {
  const _EmojiPicker({
    required this.emojis,
    required this.selected,
    required this.onSelect,
  });

  final List<String> emojis;
  final String selected;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: emojis.map((emoji) {
        final isSelected = selected == emoji;
        return GestureDetector(
          onTap: () => onSelect(emoji),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.midnightGold.withOpacity(0.15)
                  : AppColors.midnightBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppColors.midnightGold
                    : AppColors.midnightTextMuted.withOpacity(0.2),
              ),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 20)),
          ),
        );
      }).toList(),
    );
  }
}

class _FrequencyPicker extends StatelessWidget {
  const _FrequencyPicker({
    required this.frequencies,
    required this.selected,
    required this.onSelect,
  });

  final List<String> frequencies;
  final String selected;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: frequencies.map((freq) {
        final isSelected = selected == freq;
        return GestureDetector(
          onTap: () => onSelect(freq),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.midnightGold.withOpacity(0.15)
                  : AppColors.midnightBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.midnightGold
                    : AppColors.midnightTextMuted.withOpacity(0.2),
              ),
            ),
            child: Text(
              freq,
              style: TextStyle(
                color: isSelected
                    ? AppColors.midnightGold
                    : AppColors.midnightTextMuted,
                fontSize: 13,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
