// Copyright (c) 2026 Jiamini Innovations Ltd. All rights reserved.
// KezaIO - Your private AI life advisor

import 'package:equatable/equatable.dart';
import '../../../../core/constants/life_state.dart';

/// Represents the authenticated KezaIO user.
class KezaUser extends Equatable {
  const KezaUser({
    required this.id,
    this.lifeStateKey,
    this.isOnboarded = false,
    this.email,
    this.fullName,
    this.avatarUrl,
    this.isPremium = false,
  });

  final String id;
  final String? lifeStateKey;
  final bool isOnboarded;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final bool isPremium;

  LifeState get lifeState => lifeStateKey != null
      ? LifeStateExtension.fromKey(lifeStateKey!)
      : LifeState.openToOpportunities;

  KezaUser copyWith({
    String? id,
    String? lifeStateKey,
    bool? isOnboarded,
    String? email,
    String? fullName,
    String? avatarUrl,
    bool? isPremium,
  }) {
    return KezaUser(
      id: id ?? this.id,
      lifeStateKey: lifeStateKey ?? this.lifeStateKey,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  factory KezaUser.fromJson(Map<String, dynamic> json) {
    return KezaUser(
      id: json['id'] as String,
      lifeStateKey: json['life_state'] as String?,
      isOnboarded: (json['is_onboarded'] as bool?) ?? false,
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isPremium: (json['is_premium'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'life_state': lifeStateKey,
      'is_onboarded': isOnboarded,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
    };
  }

  @override
  List<Object?> get props => [
        id,
        lifeStateKey,
        isOnboarded,
        email,
        fullName,
        avatarUrl,
        isPremium,
      ];
}
