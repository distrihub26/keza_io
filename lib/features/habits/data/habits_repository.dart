// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../domain/models/habit.dart';

/// Handles habit API calls — list, create, toggle completion.
class HabitsRepository {
  HabitsRepository();

  final Dio _dio = ApiClient.instance;

  Future<List<Habit>> fetchHabits() async {
    final response = await _dio.get('/habits/');
    final data = response.data as List;
    return data.map((json) => _fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Habit> createHabit({
    required String emoji,
    required String name,
    required String frequency,
  }) async {
    final response = await _dio.post(
      '/habits/',
      data: {
        'emoji': emoji,
        'name': name,
        'frequency': _frequencyToApi(frequency),
      },
    );
    return _fromJson(response.data as Map<String, dynamic>);
  }

  Future<Habit> toggleCompletion(String habitId) async {
    final response = await _dio.post('/habits/$habitId/toggle/');
    return _fromJson(response.data as Map<String, dynamic>);
  }

  Habit _fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      emoji: json['emoji'] as String,
      name: json['name'] as String,
      frequency: _frequencyFromApi(json['frequency'] as String),
      streak: json['streak'] as int,
      isCompletedToday: json['is_completed_today'] as bool,
    );
  }

  String _frequencyToApi(String label) {
    switch (label) {
      case 'Daily':
        return 'daily';
      case '3x per week':
        return '3x_week';
      case 'Weekdays':
        return 'weekdays';
      case 'Weekends':
        return 'weekends';
      case 'Weekly':
        return 'weekly';
      default:
        return 'daily';
    }
  }

  String _frequencyFromApi(String value) {
    switch (value) {
      case 'daily':
        return 'Daily';
      case '3x_week':
        return '3x per week';
      case 'weekdays':
        return 'Weekdays';
      case 'weekends':
        return 'Weekends';
      case 'weekly':
        return 'Weekly';
      default:
        return 'Daily';
    }
  }
}
