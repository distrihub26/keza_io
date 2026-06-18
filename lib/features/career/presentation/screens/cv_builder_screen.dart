// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/cv_section_card.dart';

/// Master CV profile builder — the living document behind every
/// tailored CV. Users can update skills, education, and experience
/// anytime, and future applications reflect the changes instantly.
class CvBuilderScreen extends ConsumerWidget {
  const CvBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildToolbar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  _buildIntro(),
                  const SizedBox(height: 20),
                  CvSectionCard(
                    emoji: '👤',
                    title: 'Personal details',
                    summary: 'Katelo Smart · Full-stack Developer',
                    isComplete: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  CvSectionCard(
                    emoji: '💼',
                    title: 'Work experience',
                    summary: '3 roles added · most recent: Jiamini Innovations',
                    isComplete: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  CvSectionCard(
                    emoji: '🎓',
                    title: 'Education',
                    summary: '1 qualification added',
                    isComplete: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  CvSectionCard(
                    emoji: '🛠️',
                    title: 'Skills',
                    summary: '12 skills · Django, React, Flutter +9 more',
                    isComplete: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  CvSectionCard(
                    emoji: '📜',
                    title: 'Certifications',
                    summary: 'None added yet',
                    isComplete: false,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  CvSectionCard(
                    emoji: '🔗',
                    title: 'Links & portfolio',
                    summary: 'GitHub added · 1 more recommended',
                    isComplete: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.midnightTextMuted,
              size: 20,
            ),
          ),
          const Text(
            'Master CV profile',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: AppColors.moduleCareer, width: 3),
        ),
      ),
      child: const Text(
        'This is your living profile. Update it anytime — new skill, '
        'new certificate, new role — and every future tailored CV '
        'reflects the change instantly.',
        style: TextStyle(
          color: AppColors.midnightTextPrimary,
          fontSize: 13,
          height: 1.6,
        ),
      ),
    );
  }
}
