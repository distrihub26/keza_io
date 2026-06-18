// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../widgets/goal_card.dart';
import '../widgets/add_goal_sheet.dart';

/// Goals module — life vision and progress tracking screen.
class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

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
                  SliverToBoxAdapter(child: _buildVisionBanner()),
                  SliverToBoxAdapter(child: _buildSectionLabel('Active goals')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(_buildGoals()),
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
              'Your 2026 vision',
              style: TextStyle(
                color: AppColors.moduleGoals,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Build KezaIO into a product used by 1,000 people. '
              'Stay healthy. Read 24 books. Grow Jiamini.',
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

  List<Widget> _buildGoals() {
    return const [
      GoalCard(
        emoji: '💼',
        title: 'Launch KezaIO v1',
        category: 'Career',
        progress: 0.35,
        deadline: 'Sep 2026',
        milestones: 8,
        completed: 3,
      ),
      SizedBox(height: 12),
      GoalCard(
        emoji: '📚',
        title: 'Read 24 books',
        category: 'Learning',
        progress: 0.5,
        deadline: 'Dec 2026',
        milestones: 24,
        completed: 12,
      ),
      SizedBox(height: 12),
      GoalCard(
        emoji: '💰',
        title: 'Save KES 200,000',
        category: 'Finance',
        progress: 0.2,
        deadline: 'Dec 2026',
        milestones: 12,
        completed: 2,
      ),
      SizedBox(height: 12),
      GoalCard(
        emoji: '🏃',
        title: 'Run a half marathon',
        category: 'Health',
        progress: 0.6,
        deadline: 'Aug 2026',
        milestones: 5,
        completed: 3,
      ),
    ];
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
