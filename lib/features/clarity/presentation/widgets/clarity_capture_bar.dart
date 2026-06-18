// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'clarity_thought_card.dart';

/// Quick capture bar for dumping thoughts into the second brain.
class ClarityCaptureBar extends StatefulWidget {
  const ClarityCaptureBar({super.key});

  @override
  State<ClarityCaptureBar> createState() => _ClarityCaptureBarState();
}

class _ClarityCaptureBarState extends State<ClarityCaptureBar> {
  final _controller = TextEditingController();
  ClarityCategory _selectedCategory = ClarityCategory.idea;
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _capture() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() => _isSaving = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    _controller.clear();
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.moduleClarity.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLines: 3,
            style: const TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 14,
              height: 1.5,
            ),
            decoration: const InputDecoration(
              hintText: 'Dump a thought, idea, worry, or action...',
              hintStyle: TextStyle(
                color: AppColors.midnightTextMuted,
                fontSize: 14,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _CategorySelector(
                selected: _selectedCategory,
                onSelect: (c) => setState(() => _selectedCategory = c),
              )),
              const SizedBox(width: 12),
              _CaptureButton(
                isLoading: _isSaving,
                onTap: _capture,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.selected,
    required this.onSelect,
  });

  final ClarityCategory selected;
  final void Function(ClarityCategory) onSelect;

  static const _options = [
    (ClarityCategory.action, '✅', 'Action'),
    (ClarityCategory.idea, '💡', 'Idea'),
    (ClarityCategory.worry, '😟', 'Worry'),
    (ClarityCategory.dream, '🌟', 'Dream'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _options.map((option) {
          final (category, emoji, label) = option;
          final isSelected = selected == category;
          return GestureDetector(
            onTap: () => onSelect(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.moduleClarity.withOpacity(0.15)
                    : AppColors.midnightBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.moduleClarity
                      : AppColors.midnightTextMuted.withOpacity(0.2),
                ),
              ),
              child: Text(
                '$emoji $label',
                style: TextStyle(
                  color: isSelected
                      ? AppColors.moduleClarity
                      : AppColors.midnightTextMuted,
                  fontSize: 11,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  const _CaptureButton({
    required this.isLoading,
    required this.onTap,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.moduleClarity,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 20,
              ),
      ),
    );
  }
}
