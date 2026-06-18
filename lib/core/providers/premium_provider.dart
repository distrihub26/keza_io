// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

/// Whether the current user has an active KezaIO Premium subscription.
final isPremiumProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    data: (user) => user?.isPremium ?? false,
    orElse: () => false,
  );
});
