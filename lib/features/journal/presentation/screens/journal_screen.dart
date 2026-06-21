// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../../domain/models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../widgets/journal_entry_card.dart';
import '../widgets/journal_mood_bar.dart';
import 'journal_entry_screen.dart';

/// Mirror module — journal and reflection screen.
class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalState = ref.watch(journalProvider);

    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: journalState.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.midnightGold,
                  ),
                ),
                error: (_, __) => _buildError(context, ref),
                data: (entries) => _buildContent(context, entries),
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
      floatingActionButton: _NewEntryButton(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const JournalEntryScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            color: AppColors.midnightTextMuted,
            size: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            "Couldn't load your journal",
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => ref.read(journalProvider.notifier).loadEntries(),
            child: const Text(
              'Try again',
              style: TextStyle(color: AppColors.midnightGold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<JournalEntry> entries) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        SliverToBoxAdapter(child: _buildMoodBar()),
        SliverToBoxAdapter(child: _buildSectionLabel('Recent entries')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate(_buildEntries(entries)),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🌙 Mirror',
                style: TextStyle(
                  color: AppColors.midnightGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your private space',
                style: TextStyle(
                  color: AppColors.midnightTextPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.midnightTextMuted,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodBar() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: JournalMoodBar(),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: AppColors.midnightTextMuted,
          fontSize: 11,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  List<Widget> _buildEntries(List<JournalEntry> entries) {
    if (entries.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Text(
              "No entries yet. Tap the pencil to write your first one.",
              style: TextStyle(
                color: AppColors.midnightTextMuted,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      widgets.add(
        JournalEntryCard(
          date: _formatDate(entry.createdAt),
          preview: entry.preview,
          mood: entry.mood ?? '📝',
          wordCount: entry.wordCount,
        ),
      );
      if (i != entries.length - 1) {
        widgets.add(const SizedBox(height: 12));
      }
    }
    return widgets;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final isToday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
    final isYesterday = date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1;

    if (isToday) {
      return 'Today, ${DateFormat('h:mm a').format(date)}';
    }
    if (isYesterday) {
      return 'Yesterday, ${DateFormat('h:mm a').format(date)}';
    }
    return DateFormat('EEE, d MMM').format(date);
  }
}

class _NewEntryButton extends StatelessWidget {
  const _NewEntryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.midnightGold,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.edit_outlined,
          color: AppColors.midnightBackground,
          size: 22,
        ),
      ),
    );
  }
}
