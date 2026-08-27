import 'package:flutter/material.dart';

enum LeagueTier {
  bronze,
  silver,
  gold,
  obsidian,
  diamond;

  static LeagueTier fromString(String? val) {
    if (val == null) return LeagueTier.bronze;
    return LeagueTier.values.firstWhere(
      (e) => e.name.toLowerCase() == val.toLowerCase(),
      orElse: () => LeagueTier.bronze,
    );
  }

  String get displayName {
    switch (this) {
      case LeagueTier.bronze:
        return 'Bronze League';
      case LeagueTier.silver:
        return 'Silver League';
      case LeagueTier.gold:
        return 'Gold League';
      case LeagueTier.obsidian:
        return 'Obsidian League';
      case LeagueTier.diamond:
        return 'Diamond League';
    }
  }

  String get emblemEmoji {
    switch (this) {
      case LeagueTier.bronze:
        return '🥉';
      case LeagueTier.silver:
        return '🥈';
      case LeagueTier.gold:
        return '🥇';
      case LeagueTier.obsidian:
        return '🔮';
      case LeagueTier.diamond:
        return '💎';
    }
  }

  Color get primaryColor {
    switch (this) {
      case LeagueTier.bronze:
        return const Color(0xFFCD7F32);
      case LeagueTier.silver:
        return const Color(0xFFC0C0C0);
      case LeagueTier.gold:
        return const Color(0xFFFFD700);
      case LeagueTier.obsidian:
        return const Color(0xFF8B5CF6);
      case LeagueTier.diamond:
        return const Color(0xFF00E5FF);
    }
  }

  LeagueTier? get nextTier {
    final idx = index + 1;
    if (idx < LeagueTier.values.length) {
      return LeagueTier.values[idx];
    }
    return null;
  }

  LeagueTier? get previousTier {
    final idx = index - 1;
    if (idx >= 0) {
      return LeagueTier.values[idx];
    }
    return null;
  }
}

enum LeagueZone {
  promotion, // Ranks 1-7
  safe,      // Ranks 8-25
  demotion,  // Ranks 26-30
}

class LeagueMember {
  final String userId;
  final String username;
  final String? avatarUrl;
  final int weeklyXp;
  final int rank;
  final LeagueTier tier;
  final bool isCurrentUser;

  const LeagueMember({
    required this.userId,
    required this.username,
    this.avatarUrl,
    required this.weeklyXp,
    required this.rank,
    required this.tier,
    this.isCurrentUser = false,
  });

  LeagueZone get zone {
    if (rank <= 7) return LeagueZone.promotion;
    if (rank >= 26 && tier != LeagueTier.bronze) return LeagueZone.demotion;
    return LeagueZone.safe;
  }

  LeagueMember copyWith({
    String? userId,
    String? username,
    String? avatarUrl,
    int? weeklyXp,
    int? rank,
    LeagueTier? tier,
    bool? isCurrentUser,
  }) {
    return LeagueMember(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      weeklyXp: weeklyXp ?? this.weeklyXp,
      rank: rank ?? this.rank,
      tier: tier ?? this.tier,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}

class LeagueState {
  final LeagueTier currentTier;
  final List<LeagueMember> members;
  final DateTime weekEndsAt;
  final int currentUserRank;

  const LeagueState({
    required this.currentTier,
    required this.members,
    required this.weekEndsAt,
    required this.currentUserRank,
  });
}
