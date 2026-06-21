// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/journal_repository_provider.dart';
import '../../data/journal_repository.dart';
import '../../domain/models/journal_entry.dart';

/// Manages the list of journal entries, backed by the KezaIO API.
class JournalNotifier extends StateNotifier<AsyncValue<List<JournalEntry>>> {
  JournalNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadEntries();
  }

  final JournalRepository _repository;

  Future<void> loadEntries() async {
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.fetchEntries();
      state = AsyncValue.data(entries);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addEntry({
    required String content,
    String? mood,
  }) async {
    final entry = await _repository.createEntry(content: content, mood: mood);
    final current = state.value ?? [];
    state = AsyncValue.data([entry, ...current]);
  }
}

/// Global provider for the journal entries list.
final journalProvider =
    StateNotifierProvider<JournalNotifier, AsyncValue<List<JournalEntry>>>(
  (ref) => JournalNotifier(ref.watch(journalRepositoryProvider)),
);
