// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../widgets/journal_entry_card.dart';
import '../widgets/journal_mood_bar.dart';
import 'journal_entry_screen.dart';

/// Mirror module — journal and reflection screen.
class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildMoodBar()),
                  SliverToBoxAdapter(child: _buildSectionLabel('Recent entries')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        _buildEntries(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
      floatingActionButton: _NewEntryButton(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => const JournalEntryScreen(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  List<Widget> _buildEntries() {
    return const [
      JournalEntryCard(
        date: 'Today, 8:21 AM',
        preview: 'Woke up feeling clear. The morning run helped — '
            'I need to do that more often. Had a good meeting...',
        mood: '😊',
        wordCount: 248,
      ),
      SizedBox(height: 12),
      JournalEntryCard(
        date: 'Yesterday, 10:45 PM',
        preview: 'Long day. Felt overwhelmed by the project scope '
            'but pushed through. Grateful for the small wins today...',
        mood: '😔',
        wordCount: 183,
      ),
      SizedBox(height: 12),
      JournalEntryCard(
        date: 'Mon, 14 Jun',
        preview: 'Something shifted today. Had a conversation that '
            'made me realise I have been holding back on the things...',
        mood: '🤔',
        wordCount: 312,
      ),
      SizedBox(height: 12),
      JournalEntryCard(
        date: 'Sun, 13 Jun',
        preview: 'Rest day. Read half of the book. Made notes. '
            'Feeling recharged and ready for the week ahead...',
        mood: '😌',
        wordCount: 97,
      ),
    ];
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
