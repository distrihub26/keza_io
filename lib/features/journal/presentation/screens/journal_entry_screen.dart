// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../providers/journal_provider.dart';

/// Full-screen journal entry composer.
class JournalEntryScreen extends ConsumerStatefulWidget {
  const JournalEntryScreen({super.key});

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  final _controller = TextEditingController();
  String? _selectedMood;
  bool _isSaving = false;
  String? _errorMessage;

  static const List<String> _moods = ['😊', '😔', '😤', '😌', '🤔', '😴', '🔥'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });

    try {
      await ref.read(journalProvider.notifier).addEntry(
            content: _controller.text.trim(),
            mood: _selectedMood,
          );
      if (!mounted) return;
      Navigator.pop(context);
    } catch (_) {
      setState(() {
        _errorMessage = "Couldn't save your entry. Please try again.";
        _isSaving = false;
      });
    }
  }

  int get _wordCount {
    final text = _controller.text.trim();
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildToolbar(),
            if (_errorMessage != null) _buildErrorBanner(),
            _buildMoodSelector(),
            Expanded(child: _buildEditor()),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.midnightTextMuted,
            ),
          ),
          Column(
            children: [
              const Text(
                '🌙 Mirror',
                style: TextStyle(
                  color: AppColors.midnightGold,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _formatDate(),
                style: const TextStyle(
                  color: AppColors.midnightTextMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.midnightGold,
                  ),
                )
              : TextButton(
                  onPressed: _save,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: AppColors.midnightGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.danger.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: AppColors.danger, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How are you feeling?',
            style: TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: _moods.map((mood) {
              final isSelected = _selectedMood == mood;
              return GestureDetector(
                onTap: () => setState(() => _selectedMood = mood),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.midnightGold.withOpacity(0.15)
                        : AppColors.midnightSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.midnightGold
                          : AppColors.midnightTextMuted.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    mood,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditor() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
        controller: _controller,
        maxLines: null,
        expands: true,
        autofocus: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          color: AppColors.midnightTextPrimary,
          fontSize: 16,
          height: 1.7,
        ),
        decoration: const InputDecoration(
          hintText: "What's on your mind today?",
          hintStyle: TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 16,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.midnightTextMuted.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$_wordCount words',
            style: const TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              _FooterAction(
                icon: Icons.mic_outlined,
                onTap: () {},
              ),
              const SizedBox(width: 16),
              _FooterAction(
                icon: Icons.image_outlined,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate() {
    final now = DateTime.now();
    return '${_weekday(now.weekday)}, ${now.day} ${_month(now.month)}';
  }

  String _weekday(int w) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[w - 1];
  }

  String _month(int m) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[m - 1];
  }
}

class _FooterAction extends StatelessWidget {
  const _FooterAction({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: AppColors.midnightTextMuted,
        size: 22,
      ),
    );
  }
}
