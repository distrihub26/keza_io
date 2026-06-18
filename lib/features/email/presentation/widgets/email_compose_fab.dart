// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../screens/email_compose_screen.dart';

/// Floating action button to compose a new email.
class EmailComposeFab extends StatelessWidget {
  const EmailComposeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => const EmailComposeScreen(),
        ),
      ),
      child: Container(
        width: 52,
        height: 52,
        decoration: const BoxDecoration(
          color: AppColors.moduleEmail,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.edit_outlined,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
