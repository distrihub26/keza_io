// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../router/app_router.dart';
import '../widgets/keza_insight_card.dart';
import '../widgets/keza_module_card.dart';
import '../widgets/keza_streak_card.dart';
import '../widgets/keza_bottom_nav.dart';

/// KezaIO main home screen.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
                  SliverToBoxAdapter(child: _buildHeader()),
                  SliverToBoxAdapter(child: _buildInsightCard()),
                  SliverToBoxAdapter(child: _buildSectionLabel('Your modules')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      delegate: SliverChildListDelegate(_buildModules(context)),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildStreakCard()),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
      floatingActionButton: const _QuickCaptureButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning,',
                style: TextStyle(
                  color: AppColors.midnightTextMuted,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    'Katelo',
                    style: TextStyle(
                      color: AppColors.midnightTextPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '✦',
                    style: TextStyle(
                      color: AppColors.midnightGold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.midnightSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.midnightTextMuted.withOpacity(0.2),
              ),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.midnightTextMuted,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: KezaInsightCard(
        insight:
            "You've been journaling for 12 days. Your energy peaks on Tuesdays — something to build on.",
        label: 'Keza insight · just now',
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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

  List<Widget> _buildModules(BuildContext context) {
    return [
      KezaModuleCard(
        emoji: '🌙',
        name: 'Mirror',
        subtitle: 'Journal & reflect',
        accentColor: AppColors.moduleJournal,
        onTap: () => context.push(AppRoutes.journal),
      ),
      KezaModuleCard(
        emoji: '🔥',
        name: 'Habits',
        subtitle: '7 day streak',
        accentColor: AppColors.moduleHabits,
        onTap: () => context.push(AppRoutes.habits),
      ),
      KezaModuleCard(
        emoji: '💼',
        name: 'Career',
        subtitle: '3 new matches',
        accentColor: AppColors.moduleCareer,
        isPremium: true,
        onTap: () => context.push(AppRoutes.career),
      ),
      KezaModuleCard(
        emoji: '🧠',
        name: 'Clarity',
        subtitle: 'Brain dump',
        accentColor: AppColors.moduleClarity,
        isPremium: true,
        onTap: () => context.push(AppRoutes.clarity),
      ),
      KezaModuleCard(
        emoji: '💙',
        name: 'Pulse',
        subtitle: 'Mood & energy',
        accentColor: AppColors.modulePulse,
        onTap: () => context.push(AppRoutes.pulse),
      ),
      KezaModuleCard(
        emoji: '🎯',
        name: 'Goals',
        subtitle: 'Life vision',
        accentColor: AppColors.moduleGoals,
        onTap: () => context.push(AppRoutes.goals),
      ),
    ];
  }

  Widget _buildStreakCard() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: KezaStreakCard(
        streakDays: 12,
        bestStreak: 15,
        weekLog: [true, true, true, true, true, false, false],
      ),
    );
  }
}

class _QuickCaptureButton extends StatelessWidget {
  const _QuickCaptureButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: const BoxDecoration(
        color: AppColors.midnightGold,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.add_rounded,
        color: AppColors.midnightBackground,
        size: 28,
      ),
    );
  }
}
