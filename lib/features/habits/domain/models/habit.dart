// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:equatable/equatable.dart';

/// Represents a single trackable habit in KezaIO.
class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.emoji,
    required this.name,
    required this.frequency,
    required this.streak,
    required this.isCompletedToday,
  });

  final String id;
  final String emoji;
  final String name;
  final String frequency;
  final int streak;
  final bool isCompletedToday;

  Habit copyWith({
    String? id,
    String? emoji,
    String? name,
    String? frequency,
    int? streak,
    bool? isCompletedToday,
  }) {
    return Habit(
      id: id ?? this.id,
      emoji: emoji ?? this.emoji,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      streak: streak ?? this.streak,
      isCompletedToday: isCompletedToday ?? this.isCompletedToday,
    );
  }

  @override
  List<Object?> get props => [
        id,
        emoji,
        name,
        frequency,
        streak,
        isCompletedToday,
      ];
}
