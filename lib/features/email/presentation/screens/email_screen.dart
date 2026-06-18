// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/keza_bottom_nav.dart';
import '../widgets/email_inbox_item.dart';
import '../widgets/email_compose_fab.dart';
import '../widgets/email_domain_banner.dart';

/// Email module — personal domain email client screen.
class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  SliverToBoxAdapter(child: _buildHeader(context)),
                  SliverToBoxAdapter(child: _buildDomainBanner()),
                  SliverToBoxAdapter(child: _buildTabBar()),
                ],
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEmailList(_inboxEmails),
                    _buildEmailList(_sentEmails),
                    _buildEmailList(_draftEmails),
                  ],
                ),
              ),
            ),
            const KezaBottomNav(currentIndex: 0),
          ],
        ),
      ),
      floatingActionButton: const EmailComposeFab(),
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
                '✉️ Email',
                style: TextStyle(
                  color: AppColors.moduleEmail,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Your domain inbox',
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

  Widget _buildDomainBanner() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: EmailDomainBanner(
        email: 'katelo@jiamini.co.ke',
        isVerified: true,
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.midnightSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.moduleEmail.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.moduleEmail.withOpacity(0.4)),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: AppColors.moduleEmail,
          unselectedLabelColor: AppColors.midnightTextMuted,
          labelStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Inbox'),
            Tab(text: 'Sent'),
            Tab(text: 'Drafts'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailList(List<EmailItem> emails) {
    if (emails.isEmpty) {
      return const Center(
        child: Text(
          'Nothing here yet',
          style: TextStyle(
            color: AppColors.midnightTextMuted,
            fontSize: 14,
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      itemCount: emails.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => EmailInboxItem(item: emails[i]),
    );
  }

  static const List<EmailItem> _inboxEmails = [
    EmailItem(
      sender: 'Vijiji Hotel',
      senderEmail: 'info@vijiji.co.ke',
      subject: 'Room pricing confirmation',
      preview: 'Thank you for the updated rates. We have reviewed and approved...',
      time: '10:23 AM',
      isRead: false,
    ),
    EmailItem(
      sender: 'GitHub',
      senderEmail: 'noreply@github.com',
      subject: 'Your push to keza_io was successful',
      preview: '3 commits pushed to master branch. View the latest changes...',
      time: 'Yesterday',
      isRead: true,
    ),
    EmailItem(
      sender: 'Stripe',
      senderEmail: 'support@stripe.com',
      subject: 'Your account is ready',
      preview: 'Welcome to Stripe. Your account has been verified and is ready...',
      time: 'Mon',
      isRead: true,
    ),
  ];

  static const List<EmailItem> _sentEmails = [
    EmailItem(
      sender: 'To: Vijiji Hotel',
      senderEmail: 'info@vijiji.co.ke',
      subject: 'Updated room pricing tiers',
      preview: 'Please find the updated pricing structure for Q3 attached...',
      time: 'Yesterday',
      isRead: true,
    ),
  ];

  static const List<EmailItem> _draftEmails = [
    EmailItem(
      sender: 'Draft',
      senderEmail: '',
      subject: 'KezaIO partnership proposal',
      preview: 'I am reaching out regarding a potential partnership...',
      time: '2 days ago',
      isRead: true,
    ),
  ];
}
