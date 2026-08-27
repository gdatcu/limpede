import 'package:flutter/material.dart';

enum QuestType {
  completeReviews,
  scoreAccuracy,
  earnXp,
}

class DailyQuest {
  final String id;
  final QuestType type;
  final String title;
  final String description;
  final int currentProgress;
  final int targetProgress;
  final int xpReward;
  final int gemReward;
  final bool isClaimed;

  const DailyQuest({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.targetProgress,
    required this.xpReward,
    required this.gemReward,
    this.isClaimed = false,
  });

  bool get isCompleted => currentProgress >= targetProgress;
  double get progressRatio => (currentProgress / targetProgress).clamp(0.0, 1.0);

  IconData get icon {
    switch (type) {
      case QuestType.completeReviews:
        return Icons.rate_review_rounded;
      case QuestType.scoreAccuracy:
        return Icons.verified_rounded;
      case QuestType.earnXp:
        return Icons.bolt_rounded;
    }
  }

  DailyQuest copyWith({
    String? id,
    QuestType? type,
    String? title,
    String? description,
    int? currentProgress,
    int? targetProgress,
    int? xpReward,
    int? gemReward,
    bool? isClaimed,
  }) {
    return DailyQuest(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
      xpReward: xpReward ?? this.xpReward,
      gemReward: gemReward ?? this.gemReward,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'currentProgress': currentProgress,
      'targetProgress': targetProgress,
      'xpReward': xpReward,
      'gemReward': gemReward,
      'isClaimed': isClaimed,
    };
  }

  factory DailyQuest.fromJson(Map<String, dynamic> json) {
    return DailyQuest(
      id: json['id'] as String,
      type: QuestType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestType.earnXp,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
      targetProgress: (json['targetProgress'] as num?)?.toInt() ?? 1,
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 10,
      gemReward: (json['gemReward'] as num?)?.toInt() ?? 5,
      isClaimed: json['isClaimed'] as bool? ?? false,
    );
  }
}
