// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../domain/models/journal_entry.dart';

/// Handles journal API calls — list and create entries.
class JournalRepository {
  JournalRepository();

  final Dio _dio = ApiClient.instance;

  Future<List<JournalEntry>> fetchEntries() async {
    final response = await _dio.get('/journal/');
    final data = response.data as List;
    return data
        .map((json) => JournalEntry.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<JournalEntry> createEntry({
    required String content,
    String? mood,
  }) async {
    final response = await _dio.post(
      '/journal/',
      data: {
        'content': content,
        if (mood != null) 'mood': mood,
      },
    );
    return JournalEntry.fromJson(response.data as Map<String, dynamic>);
  }
}
