// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/goals_repository_provider.dart';
import '../../data/goals_repository.dart';
import '../../domain/models/goal.dart';

/// Manages the list of goals, backed by the KezaIO API.
class GoalsNotifier extends StateNotifier<AsyncValue<List<Goal>>> {
  GoalsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadGoals();
  }

  final GoalsRepository _repository;

  Future<void> loadGoals() async {
    state = const AsyncValue.loading();
    try {
      final goals = await _repository.fetchGoals();
      state = AsyncValue.data(goals);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addGoal({
    required String emoji,
    required String title,
    required String category,
    String? vision,
  }) async {
    final goal = await _repository.createGoal(
      emoji: emoji,
      title: title,
      category: category,
      vision: vision,
    );
    final current = state.value ?? [];
    state = AsyncValue.data([goal, ...current]);
  }
}

/// Global provider for the goals list.
final goalsProvider =
    StateNotifierProvider<GoalsNotifier, AsyncValue<List<Goal>>>(
  (ref) => GoalsNotifier(ref.watch(goalsRepositoryProvider)),
);
