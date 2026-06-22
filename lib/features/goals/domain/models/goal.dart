// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:equatable/equatable.dart';

/// Represents a single life goal tracked in KezaIO.
class Goal extends Equatable {
  const Goal({
    required this.id,
    required this.emoji,
    required this.title,
    required this.category,
    required this.milestonesTotal,
    required this.milestonesCompleted,
    this.vision,
    this.deadline,
  });

  final String id;
  final String emoji;
  final String title;
  final String? vision;
  final String category;
  final int milestonesTotal;
  final int milestonesCompleted;
  final DateTime? deadline;

  double get progress =>
      milestonesTotal == 0 ? 0 : milestonesCompleted / milestonesTotal;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] as String,
      emoji: json['emoji'] as String,
      title: json['title'] as String,
      vision: json['vision'] as String?,
      category: json['category'] as String,
      milestonesTotal: json['milestones_total'] as int,
      milestonesCompleted: json['milestones_completed'] as int,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        emoji,
        title,
        vision,
        category,
        milestonesTotal,
        milestonesCompleted,
        deadline,
      ];
}
