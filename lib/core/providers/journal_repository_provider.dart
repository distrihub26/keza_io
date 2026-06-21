// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/journal/data/journal_repository.dart';

/// Provides the JournalRepository instance for use across the app.
final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});
