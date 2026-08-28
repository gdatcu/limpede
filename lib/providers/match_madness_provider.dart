import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/srs_models.dart';
import '../providers/auth_provider.dart';
import '../providers/league_provider.dart';

part 'match_madness_provider.g.dart';

class MatchTile {
  final String id;
  final String text;
  final String pairId;
  final bool isSource;

  const MatchTile({
    required this.id,
    required this.text,
    required this.pairId,
    required this.isSource,
  });
}

class MatchMadnessState {
  final int timeRemainingSeconds;
  final int score;
  final int totalMatches;
  final int comboStreak;
  final int maxComboStreak;
  final double multiplier;
  final List<MatchTile> sourceTiles;
  final List<MatchTile> targetTiles;
  final String? selectedSourceId;
  final String? selectedTargetId;
  final Set<String> matchedPairIds;
  final bool isGameOver;
  final int dropletsEarned;
  final int xpEarned;

  const MatchMadnessState({
    this.timeRemainingSeconds = 60,
    this.score = 0,
    this.totalMatches = 0,
    this.comboStreak = 0,
    this.maxComboStreak = 0,
    this.multiplier = 1.0,
    this.sourceTiles = const [],
    this.targetTiles = const [],
    this.selectedSourceId,
    this.selectedTargetId,
    this.matchedPairIds = const {},
    this.isGameOver = false,
    this.dropletsEarned = 0,
    this.xpEarned = 0,
  });

  MatchMadnessState copyWith({
    int? timeRemainingSeconds,
    int? score,
    int? totalMatches,
    int? comboStreak,
    int? maxComboStreak,
    double? multiplier,
    List<MatchTile>? sourceTiles,
    List<MatchTile>? targetTiles,
    String? selectedSourceId,
    String? selectedTargetId,
    Set<String>? matchedPairIds,
    bool? isGameOver,
    int? dropletsEarned,
    int? xpEarned,
    bool clearSourceSelection = false,
    bool clearTargetSelection = false,
  }) {
    return MatchMadnessState(
      timeRemainingSeconds: timeRemainingSeconds ?? this.timeRemainingSeconds,
      score: score ?? this.score,
      totalMatches: totalMatches ?? this.totalMatches,
      comboStreak: comboStreak ?? this.comboStreak,
      maxComboStreak: maxComboStreak ?? this.maxComboStreak,
      multiplier: multiplier ?? this.multiplier,
      sourceTiles: sourceTiles ?? this.sourceTiles,
      targetTiles: targetTiles ?? this.targetTiles,
      selectedSourceId: clearSourceSelection ? null : (selectedSourceId ?? this.selectedSourceId),
      selectedTargetId: clearTargetSelection ? null : (selectedTargetId ?? this.selectedTargetId),
      matchedPairIds: matchedPairIds ?? this.matchedPairIds,
      isGameOver: isGameOver ?? this.isGameOver,
      dropletsEarned: dropletsEarned ?? this.dropletsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
    );
  }
}

@riverpod
class MatchMadnessController extends _$MatchMadnessController {
  Timer? _timer;
  List<SentencePair> _pool = [];
  int _poolIndex = 0;

  @override
  MatchMadnessState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const MatchMadnessState();
  }

  void startBlitz(List<SentencePair> candidatePairs) {
    _timer?.cancel();
    _pool = List.from(candidatePairs)..shuffle();
    _poolIndex = 0;

    // Take initial 5 pairs
    final initialPairs = <SentencePair>[];
    while (initialPairs.length < 5 && _poolIndex < _pool.length) {
      initialPairs.add(_pool[_poolIndex++]);
    }

    final sources = initialPairs
        .map((p) => MatchTile(
              id: 'src_${p.id}',
              text: p.sourceText,
              pairId: p.id,
              isSource: true,
            ))
        .toList()
      ..shuffle();

    final targets = initialPairs
        .map((p) => MatchTile(
              id: 'tgt_${p.id}',
              text: p.targetText,
              pairId: p.id,
              isSource: false,
            ))
        .toList()
      ..shuffle();

    state = MatchMadnessState(
      timeRemainingSeconds: 60,
      sourceTiles: sources,
      targetTiles: targets,
      isGameOver: false,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeRemainingSeconds <= 1) {
        timer.cancel();
        _finishGame();
      } else {
        state = state.copyWith(timeRemainingSeconds: state.timeRemainingSeconds - 1);
      }
    });
  }

  void selectTile(MatchTile tile) {
    if (state.isGameOver) return;

    if (tile.isSource) {
      if (state.selectedSourceId == tile.id) {
        state = state.copyWith(clearSourceSelection: true);
      } else {
        state = state.copyWith(selectedSourceId: tile.id);
        _checkMatch();
      }
    } else {
      if (state.selectedTargetId == tile.id) {
        state = state.copyWith(clearTargetSelection: true);
      } else {
        state = state.copyWith(selectedTargetId: tile.id);
        _checkMatch();
      }
    }
  }

  void _checkMatch() {
    if (state.selectedSourceId == null || state.selectedTargetId == null) return;

    final sourceTile = state.sourceTiles.firstWhere(
      (t) => t.id == state.selectedSourceId,
      orElse: () => const MatchTile(id: '', text: '', pairId: '', isSource: true),
    );
    final targetTile = state.targetTiles.firstWhere(
      (t) => t.id == state.selectedTargetId,
      orElse: () => const MatchTile(id: '', text: '', pairId: '', isSource: false),
    );

    if (sourceTile.id.isEmpty || targetTile.id.isEmpty) {
      state = state.copyWith(clearSourceSelection: true, clearTargetSelection: true);
      return;
    }

    final isMatch = sourceTile.pairId == targetTile.pairId;

    if (isMatch) {
      final newStreak = state.comboStreak + 1;
      final newMaxStreak = newStreak > state.maxComboStreak ? newStreak : state.maxComboStreak;
      
      // Calculate multiplier
      double newMultiplier = 1.0;
      if (newStreak >= 10) {
        newMultiplier = 3.0;
      } else if (newStreak >= 6) {
        newMultiplier = 2.0;
      } else if (newStreak >= 3) {
        newMultiplier = 1.5;
      }

      final points = (10 * newMultiplier).round();
      final newScore = state.score + points;
      final newTotalMatches = state.totalMatches + 1;

      // Replenish tiles from pool
      SentencePair? nextPair;
      if (_poolIndex < _pool.length) {
        nextPair = _pool[_poolIndex++];
      } else if (_pool.isNotEmpty) {
        _pool.shuffle();
        _poolIndex = 0;
        nextPair = _pool[_poolIndex++];
      }

      final updatedSources = state.sourceTiles.map((t) {
        if (t.id == sourceTile.id && nextPair != null) {
          return MatchTile(
            id: 'src_${nextPair.id}_${DateTime.now().millisecondsSinceEpoch}',
            text: nextPair.sourceText,
            pairId: nextPair.id,
            isSource: true,
          );
        }
        return t;
      }).toList();

      final updatedTargets = state.targetTiles.map((t) {
        if (t.id == targetTile.id && nextPair != null) {
          return MatchTile(
            id: 'tgt_${nextPair.id}_${DateTime.now().millisecondsSinceEpoch}',
            text: nextPair.targetText,
            pairId: nextPair.id,
            isSource: false,
          );
        }
        return t;
      }).toList();

      state = state.copyWith(
        score: newScore,
        totalMatches: newTotalMatches,
        comboStreak: newStreak,
        maxComboStreak: newMaxStreak,
        multiplier: newMultiplier,
        sourceTiles: updatedSources,
        targetTiles: updatedTargets,
        clearSourceSelection: true,
        clearTargetSelection: true,
      );
    } else {
      // Wrong match resets combo
      state = state.copyWith(
        comboStreak: 0,
        multiplier: 1.0,
        clearSourceSelection: true,
        clearTargetSelection: true,
      );
    }
  }

  void _finishGame() {
    _timer?.cancel();
    final droplets = (state.totalMatches / 5).floor();
    final xp = (state.score / 5).round().clamp(10, 100);

    state = state.copyWith(
      isGameOver: true,
      dropletsEarned: droplets,
      xpEarned: xp,
      clearSourceSelection: true,
      clearTargetSelection: true,
    );

    // Credit rewards to user
    try {
      ref.read(authNotifierProvider.notifier).completeLesson(
            topic: 'Match Madness Blitz',
            xpEarned: xp,
            isReview: true,
          );
      ref.invalidate(currentUserProfileProvider);
      ref.invalidate(leagueControllerProvider);
    } catch (e) {
      debugPrint('Error crediting Match Madness rewards: $e');
    }
  }
}
