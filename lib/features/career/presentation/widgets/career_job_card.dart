// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Displays a single AI-matched job listing card.
class CareerJobCard extends StatelessWidget {
  const CareerJobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.isLocal,
    required this.matchScore,
    required this.postedAt,
  });

  final String title;
  final String company;
  final String location;
  final String type;
  final bool isLocal;
  final int matchScore;
  final String postedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.midnightTextMuted.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.midnightTextPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _MatchBadge(score: matchScore),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            company,
            style: const TextStyle(
              color: AppColors.moduleCareer,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Tag(
                label: location,
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(width: 8),
              _Tag(label: type, icon: Icons.work_outline_rounded),
              const SizedBox(width: 8),
              _LocalBadge(isLocal: isLocal),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                postedAt,
                style: const TextStyle(
                  color: AppColors.midnightTextMuted,
                  fontSize: 11,
                ),
              ),
              Row(
                children: [
                  _ActionButton(
                    label: 'Save',
                    icon: Icons.bookmark_border_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _ActionButton(
                    label: 'Apply',
                    icon: Icons.send_rounded,
                    isPrimary: true,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatchBadge extends StatelessWidget {
  const _MatchBadge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.moduleCareer.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.moduleCareer.withOpacity(0.3),
        ),
      ),
      child: Text(
        '$score% match',
        style: const TextStyle(
          color: AppColors.moduleCareer,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.midnightTextMuted, size: 12),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _LocalBadge extends StatelessWidget {
  const _LocalBadge({required this.isLocal});

  final bool isLocal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isLocal
            ? AppColors.success.withOpacity(0.1)
            : AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isLocal ? 'Local' : 'International',
        style: TextStyle(
          color: isLocal ? AppColors.success : AppColors.info,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.moduleCareer
              : AppColors.midnightBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPrimary
                ? AppColors.moduleCareer
                : AppColors.midnightTextMuted.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: isPrimary
                  ? Colors.white
                  : AppColors.midnightTextMuted,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isPrimary
                    ? Colors.white
                    : AppColors.midnightTextMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
