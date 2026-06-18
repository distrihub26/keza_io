// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../widgets/pulse_checkin_card.dart';
import '../widgets/pulse_energy_chart.dart';
import '../widgets/pulse_stat_card.dart';

/// Pulse module — mood and energy tracking screen.
class PulseScreen extends ConsumerWidget {
  const PulseScreen({super.key});

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
                  SliverToBoxAdapter(child: _buildCheckIn()),
                  SliverToBoxAdapter(child: _buildSectionLabel('This week')),
                  SliverToBoxAdapter(child: _buildEnergyChart()),
                  SliverToBoxAdapter(child: _buildSectionLabel('Insights')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      delegate: SliverChildListDelegate(_buildStats()),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.4,
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
                '💙 Pulse',
                style: TextStyle(
                  color: AppColors.modulePulse,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Mood & energy',
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

  Widget _buildCheckIn() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: PulseCheckInCard(),
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

  Widget _buildEnergyChart() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PulseEnergyChart(),
    );
  }

  List<Widget> _buildStats() {
    return const [
      PulseStatCard(
        label: 'Best day',
        value: 'Tuesday',
        emoji: '⚡',
        subtitle: 'Highest energy',
      ),
      PulseStatCard(
        label: 'Avg mood',
        value: '😊',
        emoji: '📊',
        subtitle: 'This week',
      ),
      PulseStatCard(
        label: 'Check-ins',
        value: '5 / 7',
        emoji: '✅',
        subtitle: 'Days this week',
      ),
      PulseStatCard(
        label: 'Sleep avg',
        value: '6.8h',
        emoji: '😴',
        subtitle: 'This week',
      ),
    ];
  }
}
