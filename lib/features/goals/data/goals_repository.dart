// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../domain/models/goal.dart';

/// Handles goal API calls — list and create goals.
class GoalsRepository {
  GoalsRepository();

  final Dio _dio = ApiClient.instance;

  Future<List<Goal>> fetchGoals() async {
    final response = await _dio.get('/goals/');
    final data = response.data as List;
    return data.map((json) => Goal.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Goal> createGoal({
    required String emoji,
    required String title,
    required String category,
    String? vision,
    int milestonesTotal = 1,
    DateTime? deadline,
  }) async {
    final response = await _dio.post(
      '/goals/',
      data: {
        'emoji': emoji,
        'title': title,
        'category': _categoryToApi(category),
        if (vision != null) 'vision': vision,
        'milestones_total': milestonesTotal,
        if (deadline != null)
          'deadline': deadline.toIso8601String().split('T').first,
      },
    );
    return Goal.fromJson(response.data as Map<String, dynamic>);
  }

  String _categoryToApi(String label) => label.toLowerCase();
}
