// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/habit.dart';

/// Manages the list of habits and their daily completion state.
class HabitsNotifier extends StateNotifier<List<Habit>> {
  HabitsNotifier() : super(_initialHabits);

  static const _uuid = Uuid();

  static final List<Habit> _initialHabits = [
    const Habit(
      id: '1',
      emoji: '🏃',
      name: 'Morning run',
      frequency: 'Daily',
      streak: 7,
      isCompletedToday: true,
    ),
    const Habit(
      id: '2',
      emoji: '📖',
      name: 'Read 20 pages',
      frequency: 'Daily',
      streak: 5,
      isCompletedToday: true,
    ),
    const Habit(
      id: '3',
      emoji: '💧',
      name: 'Drink 2L water',
      frequency: 'Daily',
      streak: 12,
      isCompletedToday: true,
    ),
    const Habit(
      id: '4',
      emoji: '🧘',
      name: 'Meditate',
      frequency: 'Daily',
      streak: 3,
      isCompletedToday: false,
    ),
    const Habit(
      id: '5',
      emoji: '✍️',
      name: 'Journal entry',
      frequency: 'Daily',
      streak: 12,
      isCompletedToday: false,
    ),
    const Habit(
      id: '6',
      emoji: '💪',
      name: 'Workout',
      frequency: '3x per week',
      streak: 4,
      isCompletedToday: false,
    ),
  ];

  /// Toggles today's completion state for a habit and adjusts the streak.
  void toggleCompletion(String habitId) {
    state = state.map((habit) {
      if (habit.id != habitId) return habit;
      final nowCompleted = !habit.isCompletedToday;
      return habit.copyWith(
        isCompletedToday: nowCompleted,
        streak: nowCompleted ? habit.streak + 1 : habit.streak - 1,
      );
    }).toList();
  }

  /// Adds a new habit to the list.
  void addHabit({
    required String emoji,
    required String name,
    required String frequency,
  }) {
    final habit = Habit(
      id: _uuid.v4(),
      emoji: emoji,
      name: name,
      frequency: frequency,
      streak: 0,
      isCompletedToday: false,
    );
    state = [...state, habit];
  }

  int get completedCount =>
      state.where((h) => h.isCompletedToday).length;

  int get remainingCount =>
      state.where((h) => !h.isCompletedToday).length;
}

/// Global provider for the habits list.
final habitsProvider =
    StateNotifierProvider<HabitsNotifier, List<Habit>>(
  (ref) => HabitsNotifier(),
);
