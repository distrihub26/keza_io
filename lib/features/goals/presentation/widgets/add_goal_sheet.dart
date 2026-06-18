// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../features/auth/presentation/widgets/keza_text_field.dart';
import '../../../../features/auth/presentation/widgets/keza_primary_button.dart';

/// Bottom sheet for adding a new life goal.
class AddGoalSheet extends StatefulWidget {
  const AddGoalSheet({super.key});

  @override
  State<AddGoalSheet> createState() => _AddGoalSheetState();
}

class _AddGoalSheetState extends State<AddGoalSheet> {
  final _titleController = TextEditingController();
  final _visionController = TextEditingController();
  String _selectedEmoji = '🎯';
  String _selectedCategory = 'Career';
  bool _isSaving = false;

  static const List<String> _emojis = [
    '🎯', '💼', '📚', '💰', '🏃', '❤️',
    '🌍', '🎵', '🧠', '🏠', '✈️', '🌱',
  ];

  static const List<String> _categories = [
    'Career', 'Learning', 'Finance', 'Health',
    'Relationships', 'Personal', 'Travel', 'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _visionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20, 20, 20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SheetHandle(),
            const SizedBox(height: 20),
            const Text(
              'New goal',
              style: TextStyle(
                color: AppColors.midnightTextPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            KezaTextField(
              controller: _titleController,
              label: 'Goal title',
              hint: 'e.g. Launch KezaIO v1',
            ),
            const SizedBox(height: 16),
            KezaTextField(
              controller: _visionController,
              label: 'Why does this matter to you?',
              hint: 'Write your vision for this goal...',
              maxLines: 3,
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
              'Category',
              style: TextStyle(
                color: AppColors.midnightTextPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            _CategoryPicker(
              categories: _categories,
              selected: _selectedCategory,
              onSelect: (c) => setState(() => _selectedCategory = c),
            ),
            const SizedBox(height: 24),
            KezaPrimaryButton(
              label: 'Add goal',
              isLoading: _isSaving,
              onPressed: _save,
            ),
          ],
        ),
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
                  ? AppColors.moduleGoals.withOpacity(0.15)
                  : AppColors.midnightBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppColors.moduleGoals
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

class _CategoryPicker extends StatelessWidget {
  const _CategoryPicker({
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  final List<String> categories;
  final String selected;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((cat) {
        final isSelected = selected == cat;
        return GestureDetector(
          onTap: () => onSelect(cat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.moduleGoals.withOpacity(0.15)
                  : AppColors.midnightBackground,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.moduleGoals
                    : AppColors.midnightTextMuted.withOpacity(0.2),
              ),
            ),
            child: Text(
              cat,
              style: TextStyle(
                color: isSelected
                    ? AppColors.moduleGoals
                    : AppColors.midnightTextMuted,
                fontSize: 13,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
