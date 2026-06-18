// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../widgets/clarity_capture_bar.dart';
import '../widgets/clarity_thought_card.dart';

/// Clarity module — second brain and brain dump screen.
class ClarityScreen extends ConsumerWidget {
  const ClarityScreen({super.key});

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
                  SliverToBoxAdapter(child: _buildCaptureBar()),
                  SliverToBoxAdapter(child: _buildSectionLabel('Actions')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        _buildThoughts(ClarityCategory.action),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionLabel('Ideas')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        _buildThoughts(ClarityCategory.idea),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionLabel('Worries')),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        _buildThoughts(ClarityCategory.worry),
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
                '🧠 Clarity',
                style: TextStyle(
                  color: AppColors.moduleClarity,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your second brain',
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

  Widget _buildCaptureBar() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: ClarityCaptureBar(),
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

  List<Widget> _buildThoughts(ClarityCategory category) {
    final thoughts = _mockThoughts
        .where((t) => t.category == category)
        .toList();
    return thoughts.map((t) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ClarityThoughtCard(thought: t),
      );
    }).toList();
  }

  static const List<ClarityThought> _mockThoughts = [
    ClarityThought(
      text: 'Follow up with the Vijiji Hotel team about room pricing tiers',
      category: ClarityCategory.action,
      createdAt: 'Today',
    ),
    ClarityThought(
      text: 'Push the KezaIO onboarding commit before end of week',
      category: ClarityCategory.action,
      createdAt: 'Today',
    ),
    ClarityThought(
      text: 'What if KezaIO had a voice journal mode — speak, AI transcribes',
      category: ClarityCategory.idea,
      createdAt: 'Yesterday',
    ),
    ClarityThought(
      text: 'Integrate M-Pesa STK push directly into the premium upgrade flow',
      category: ClarityCategory.idea,
      createdAt: 'Yesterday',
    ),
    ClarityThought(
      text: 'Am I spreading too thin between DistriHub and KezaIO right now?',
      category: ClarityCategory.worry,
      createdAt: '2 days ago',
    ),
  ];
}
