// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

/// Represents the current season of life a user is in.
/// This drives KezaIO's behaviour, suggestions, and module emphasis.
enum LifeState {
  activelyJobHunting,
  openToOpportunities,
  growingInRole,
  freelancing,
  takingABreak,
  student,
}

/// Extension to provide display metadata for each life state.
extension LifeStateExtension on LifeState {
  String get label {
    switch (this) {
      case LifeState.activelyJobHunting:
        return 'Actively job hunting';
      case LifeState.openToOpportunities:
        return 'Open to opportunities';
      case LifeState.growingInRole:
        return 'Growing in my current role';
      case LifeState.freelancing:
        return 'Freelancing / building something';
      case LifeState.takingABreak:
        return 'Taking a break';
      case LifeState.student:
        return 'Student / just starting out';
    }
  }

  String get description {
    switch (this) {
      case LifeState.activelyJobHunting:
        return 'Daily job matches, CV tailoring, deadline reminders.';
      case LifeState.openToOpportunities:
        return 'Weekly suggestions and gentle prompts.';
      case LifeState.growingInRole:
        return 'Learning resources and skills gap analysis.';
      case LifeState.freelancing:
        return 'Project goals, client tracking, portfolio tips.';
      case LifeState.takingABreak:
        return 'Journaling focus, mindfulness and energy tracking.';
      case LifeState.student:
        return 'Learning paths, first-job guidance, CV builder.';
    }
  }

  String get emoji {
    switch (this) {
      case LifeState.activelyJobHunting:
        return '🎯';
      case LifeState.openToOpportunities:
        return '👀';
      case LifeState.growingInRole:
        return '📈';
      case LifeState.freelancing:
        return '🛠️';
      case LifeState.takingABreak:
        return '🌿';
      case LifeState.student:
        return '📚';
    }
  }

  String get key {
    return toString().split('.').last;
  }

  static LifeState fromKey(String key) {
    return LifeState.values.firstWhere(
      (state) => state.key == key,
      orElse: () => LifeState.openToOpportunities,
    );
  }
}
