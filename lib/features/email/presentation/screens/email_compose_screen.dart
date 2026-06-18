// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../features/auth/presentation/widgets/keza_text_field.dart';

/// Email compose screen — write and send from your domain email.
class EmailComposeScreen extends ConsumerStatefulWidget {
  const EmailComposeScreen({super.key});

  @override
  ConsumerState<EmailComposeScreen> createState() =>
      _EmailComposeScreenState();
}

class _EmailComposeScreenState extends ConsumerState<EmailComposeScreen> {
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_toController.text.trim().isEmpty ||
        _subjectController.text.trim().isEmpty ||
        _bodyController.text.trim().isEmpty) {
      return;
    }
    setState(() => _isSending = true);
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _isSending = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email sent from katelo@jiamini.co.ke'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildToolbar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildFromRow(),
                    const SizedBox(height: 16),
                    KezaTextField(
                      controller: _toController,
                      label: 'To',
                      hint: 'recipient@example.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    KezaTextField(
                      controller: _subjectController,
                      label: 'Subject',
                      hint: 'What is this about?',
                    ),
                    const SizedBox(height: 16),
                    _buildBodyField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.midnightTextMuted,
            ),
          ),
          const Text(
            'New message',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          _isSending
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.moduleEmail,
                  ),
                )
              : GestureDetector(
                  onTap: _send,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.moduleEmail,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildFromRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.midnightSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.midnightTextMuted.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'From',
            style: TextStyle(
              color: AppColors.midnightTextMuted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'katelo@jiamini.co.ke',
            style: TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '✓ verified',
              style: TextStyle(
                color: AppColors.success,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Message',
          style: TextStyle(
            color: AppColors.midnightTextPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(minHeight: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.midnightSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.midnightTextMuted.withOpacity(0.2),
            ),
          ),
          child: TextField(
            controller: _bodyController,
            maxLines: null,
            style: const TextStyle(
              color: AppColors.midnightTextPrimary,
              fontSize: 14,
              height: 1.6,
            ),
            decoration: const InputDecoration(
              hintText: 'Write your message...',
              hintStyle: TextStyle(
                color: AppColors.midnightTextMuted,
                fontSize: 14,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
