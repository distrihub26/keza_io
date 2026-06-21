// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/habits_repository_provider.dart';
import '../../data/habits_repository.dart';
import '../../domain/models/habit.dart';

/// Manages the list of habits, backed by the KezaIO API.
class HabitsNotifier extends StateNotifier<AsyncValue<List<Habit>>> {
  HabitsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadHabits();
  }

  final HabitsRepository _repository;

  Future<void> loadHabits() async {
    state = const AsyncValue.loading();
    try {
      final habits = await _repository.fetchHabits();
      state = AsyncValue.data(habits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> toggleCompletion(String habitId) async {
    final current = state.value;
    if (current == null) return;

    // Optimistic update
    state = AsyncValue.data(
      current.map((habit) {
        if (habit.id != habitId) return habit;
        final nowCompleted = !habit.isCompletedToday;
        return habit.copyWith(
          isCompletedToday: nowCompleted,
          streak: nowCompleted ? habit.streak + 1 : habit.streak - 1,
        );
      }).toList(),
    );

    try {
      final updated = await _repository.toggleCompletion(habitId);
      final list = state.value;
      if (list == null) return;
      state = AsyncValue.data(
        list.map((h) => h.id == updated.id ? updated : h).toList(),
      );
    } catch (_) {
      // Roll back on failure
      state = AsyncValue.data(current);
    }
  }

  Future<void> addHabit({
    required String emoji,
    required String name,
    required String frequency,
  }) async {
    final newHabit = await _repository.createHabit(
      emoji: emoji,
      name: name,
      frequency: frequency,
    );
    final current = state.value ?? [];
    state = AsyncValue.data([...current, newHabit]);
  }

  int get completedCount =>
      state.value?.where((h) => h.isCompletedToday).length ?? 0;

  int get remainingCount =>
      state.value?.where((h) => !h.isCompletedToday).length ?? 0;
}

/// Global provider for the habits list.
final habitsProvider =
    StateNotifierProvider<HabitsNotifier, AsyncValue<List<Habit>>>(
  (ref) => HabitsNotifier(ref.watch(habitsRepositoryProvider)),
);
