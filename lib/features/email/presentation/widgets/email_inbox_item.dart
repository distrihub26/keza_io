// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Data model for a single email item.
class EmailItem {
  const EmailItem({
    required this.sender,
    required this.senderEmail,
    required this.subject,
    required this.preview,
    required this.time,
    required this.isRead,
  });

  final String sender;
  final String senderEmail;
  final String subject;
  final String preview;
  final String time;
  final bool isRead;
}

/// Displays a single email row in the inbox list.
class EmailInboxItem extends StatelessWidget {
  const EmailInboxItem({super.key, required this.item});

  final EmailItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isRead
              ? AppColors.midnightTextMuted.withOpacity(0.15)
              : AppColors.moduleEmail.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(sender: item.sender),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.sender,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: item.isRead
                              ? AppColors.midnightTextMuted
                              : AppColors.midnightTextPrimary,
                          fontSize: 14,
                          fontWeight: item.isRead
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: const TextStyle(
                        color: AppColors.midnightTextMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.subject,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.midnightTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.midnightTextMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (!item.isRead) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.moduleEmail,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.sender});

  final String sender;

  @override
  Widget build(BuildContext context) {
    final initial = sender.isNotEmpty ? sender[0].toUpperCase() : '?';
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.moduleEmail.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.moduleEmail.withOpacity(0.3),
        ),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            color: AppColors.moduleEmail,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
