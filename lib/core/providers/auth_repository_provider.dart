// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/data/auth_repository.dart';

/// Provides the AuthRepository instance for use across the app.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
