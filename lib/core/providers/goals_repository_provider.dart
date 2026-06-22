// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/goals/data/goals_repository.dart';

/// Provides the GoalsRepository instance for use across the app.
final goalsRepositoryProvider = Provider<GoalsRepository>((ref) {
  return GoalsRepository();
});
