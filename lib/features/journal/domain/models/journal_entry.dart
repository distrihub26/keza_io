// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:equatable/equatable.dart';

/// Represents a single Mirror journal entry.
class JournalEntry extends Equatable {
  const JournalEntry({
    required this.id,
    required this.content,
    required this.wordCount,
    required this.createdAt,
    this.mood,
  });

  final String id;
  final String content;
  final String? mood;
  final int wordCount;
  final DateTime createdAt;

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] as String,
      content: json['content'] as String,
      mood: json['mood'] as String?,
      wordCount: json['word_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  String get preview =>
      content.length > 120 ? '${content.substring(0, 120)}...' : content;

  @override
  List<Object?> get props => [id, content, mood, wordCount, createdAt];
}
