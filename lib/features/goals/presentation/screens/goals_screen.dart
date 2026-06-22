// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../../domain/models/goal.dart';
import '../providers/goals_provider.dart';
import '../widgets/goal_card.dart';
import '../widgets/add_goal_sheet.dart';

/// Goals module — life vision and progress tracking screen.
class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsState = ref.watch(goalsProvider);

    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: goalsState.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.moduleGoals,
                  ),
                ),
                error: (_, __) => _buildError(context, ref),
                data: (goals) => _buildContent(context, goals),
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
      floatingActionButton: _AddGoalButton(
        onTap: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.midnightSurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => const AddGoalSheet(),
        ),
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
            "Couldn't load your goals",
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => ref.read(goalsProvider.notifier).loadGoals(),
            child: const Text(
              'Try again',
              style: TextStyle(color: AppColors.moduleGoals),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Goal> goals) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context)),
        SliverToBoxAdapter(child: _buildVisionBanner()),
        SliverToBoxAdapter(child: _buildSectionLabel('Active goals')),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate(_buildGoalCards(goals)),
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
                '🎯 Goals',
                style: TextStyle(
                  color: AppColors.moduleGoals,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your life vision',
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

  Widget _buildVisionBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.midnightSurface,
          borderRadius: BorderRadius.circular(14),
          border: const Border(
            left: BorderSide(color: AppColors.moduleGoals, width: 3),
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your vision',
              style: TextStyle(
                color: AppColors.moduleGoals,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Track what matters and let KezaIO connect your daily '
              'life back to your bigger goals.',
              style: TextStyle(
                color: AppColors.midnightTextPrimary,
                fontSize: 14,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
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

  List<Widget> _buildGoalCards(List<Goal> goals) {
    if (goals.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Text(
              'No goals yet. Tap + to set your first one.',
              style: TextStyle(
                color: AppColors.midnightTextMuted,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];
    for (var i = 0; i < goals.length; i++) {
      final goal = goals[i];
      widgets.add(
        GoalCard(
          emoji: goal.emoji,
          title: goal.title,
          category: _capitalize(goal.category),
          progress: goal.progress,
          deadline: goal.deadline != null
              ? DateFormat('MMM yyyy').format(goal.deadline!)
              : 'No deadline',
          milestones: goal.milestonesTotal,
          completed: goal.milestonesCompleted,
        ),
      );
      if (i != goals.length - 1) {
        widgets.add(const SizedBox(height: 12));
      }
    }
    return widgets;
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}

class _AddGoalButton extends StatelessWidget {
  const _AddGoalButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.moduleGoals,
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
