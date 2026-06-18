// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../providers/habits_provider.dart';
import '../widgets/habit_card.dart';
import '../widgets/add_habit_sheet.dart';

/// Habits module — daily habit tracking screen.
class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final notifier = ref.read(habitsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(
                    child: _buildSummary(
                      notifier.completedCount,
                      notifier.remainingCount,
                      habits,
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionLabel('Today')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        _buildHabitCards(habits, notifier),
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
      floatingActionButton: _AddHabitButton(
        onTap: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.midnightSurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const AddHabitSheet(),
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
                '🔥 Habits',
                style: TextStyle(
                  color: AppColors.moduleHabits,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Build your streaks',
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

  Widget _buildSummary(int completed, int remaining, List habits) {
    final bestStreak = habits.isEmpty
        ? 0
        : habits.map((h) => h.streak as int).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.midnightSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.midnightTextMuted.withOpacity(0.15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(value: '$completed', label: 'Completed'),
            const _Divider(),
            _SummaryItem(value: '$remaining', label: 'Remaining'),
            const _Divider(),
            _SummaryItem(value: '$bestStreak', label: 'Best streak'),
          ],
        ),
      ),
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

  List<Widget> _buildHabitCards(List habits, HabitsNotifier notifier) {
    final widgets = <Widget>[];
    for (var i = 0; i < habits.length; i++) {
      final habit = habits[i];
      widgets.add(
        GestureDetector(
          onTap: () => notifier.toggleCompletion(habit.id),
          child: HabitCard(
            emoji: habit.emoji,
            name: habit.name,
            streak: habit.streak,
            isCompleted: habit.isCompletedToday,
            frequency: habit.frequency,
          ),
        ),
      );
      if (i != habits.length - 1) {
        widgets.add(const SizedBox(height: 12));
      }
    }
    return widgets;
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.midnightGold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: AppColors.midnightTextMuted.withOpacity(0.2),
    );
  }
}

class _AddHabitButton extends StatelessWidget {
  const _AddHabitButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.moduleHabits,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
