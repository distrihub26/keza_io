// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../../../../core/providers/premium_provider.dart';
import '../widgets/career_life_state_banner.dart';
import '../widgets/career_job_card.dart';
import '../widgets/career_stats_row.dart';
import '../widgets/career_premium_gate.dart';
import 'cv_builder_screen.dart';

/// Career module — AI job matching and application engine screen.
class CareerScreen extends ConsumerWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildLifeStateBanner()),
                  SliverToBoxAdapter(child: _buildStatsRow()),
                  SliverToBoxAdapter(child: _buildCVButton(context)),
                  SliverToBoxAdapter(
                    child: _buildSectionLabel('Job matches for you'),
                  ),
                  if (isPremium)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(_buildJobCards()),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: _buildPremiumGate(context),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
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
                '💼 Career',
                style: TextStyle(
                  color: AppColors.moduleCareer,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your career co-pilot',
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

  Widget _buildLifeStateBanner() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: CareerLifeStateBanner(
        lifeState: 'Actively job hunting',
        emoji: '🎯',
      ),
    );
  }

  Widget _buildStatsRow() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: CareerStatsRow(
        applied: 12,
        inReview: 3,
        interviews: 1,
        responseRate: 25,
      ),
    );
  }

  Widget _buildCVButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => const CvBuilderScreen(),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.midnightSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.moduleCareer.withOpacity(0.3),
            ),
          ),
          child: const Row(
            children: [
              Text('📄', style: TextStyle(fontSize: 24)),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Master CV profile',
                      style: TextStyle(
                        color: AppColors.midnightTextPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tap to view or update your profile',
                      style: TextStyle(
                        color: AppColors.midnightTextMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.midnightTextMuted,
                size: 20,
              ),
            ],
          ),
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

  Widget _buildPremiumGate(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: CareerPremiumGate(),
    );
  }

  List<Widget> _buildJobCards() {
    return const [
      CareerJobCard(
        title: 'Senior Flutter Developer',
        company: 'Safaricom PLC',
        location: 'Nairobi, Kenya',
        type: 'Full-time',
        isLocal: true,
        matchScore: 92,
        postedAt: '2 days ago',
      ),
      SizedBox(height: 12),
      CareerJobCard(
        title: 'Mobile Engineer',
        company: 'Andela',
        location: 'Remote',
        type: 'Contract',
        isLocal: false,
        matchScore: 87,
        postedAt: '1 day ago',
      ),
      SizedBox(height: 12),
      CareerJobCard(
        title: 'Full Stack Developer',
        company: 'Cellulant',
        location: 'Nairobi, Kenya',
        type: 'Full-time',
        isLocal: true,
        matchScore: 81,
        postedAt: 'Today',
      ),
    ];
  }
}
