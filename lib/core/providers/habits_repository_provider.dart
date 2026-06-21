// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/habits/data/habits_repository.dart';

/// Provides the HabitsRepository instance for use across the app.
final habitsRepositoryProvider = Provider<HabitsRepository>((ref) {
  return HabitsRepository();
});
