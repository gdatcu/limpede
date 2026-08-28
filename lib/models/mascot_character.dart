import 'package:flutter/material.dart';

enum MascotId {
  pede,
  nyx,
  volta,
  kora,
  boba,
}

enum MascotMood {
  idle,
  thinking,
  anticipating,
  celebrating,
  sympathetic,
  streakFire,
  dizzy,
  sleeping,
}

enum MascotHeadFeature {
  lightningAntenna,
  crescentCrown,
  flameSpikes,
  zenLeaf,
  bubbleBlush,
}

class MascotCharacter {
  final MascotId id;
  final String name;
  final String emoji;
  final String title;
  final String tagline;
  final String description;
  final Color primaryColor;
  final Color secondaryColor;
  final Color glowColor;
  final Color eyeColor;
  final Color sparkColor;
  final MascotHeadFeature headFeature;
  final double voicePitch;

  const MascotCharacter({
    required this.id,
    required this.name,
    required this.emoji,
    required this.title,
    required this.tagline,
    required this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.glowColor,
    required this.eyeColor,
    required this.sparkColor,
    required this.headFeature,
    this.voicePitch = 1.0,
  });

  static const MascotCharacter pede = MascotCharacter(
    id: MascotId.pede,
    name: 'Pede',
    emoji: '⚡💧',
    title: 'The Crystal Spark',
    tagline: 'Crystal clear focus & lightning recall!',
    description:
        'Limpede\'s iconic companion. Curious, optimistic, and always ready to turn complex grammar crystal clear.',
    primaryColor: Color(0xFF00E5FF), // Electric Cyan
    secondaryColor: Color(0xFF0091EA), // Deep Ocean Azure
    glowColor: Color(0xFF80D8FF), // Crystal Aqua Glow
    eyeColor: Color(0xFF002171), // Deep Navy
    sparkColor: Color(0xFFFFD600), // Golden Spark
    headFeature: MascotHeadFeature.lightningAntenna,
    voicePitch: 1.1,
  );

  static const MascotCharacter nyx = MascotCharacter(
    id: MascotId.nyx,
    name: 'Nyx',
    emoji: '🌙🔮',
    title: 'The Sarcastic Polyglot',
    tagline: 'Mildly impressed by your streak.',
    description:
        'A witty, sharp-tongued shadow amethyst sprite. Gives deadpan compliments and pushes you to never settle for average.',
    primaryColor: Color(0xFFAB47BC), // Rich Amethyst
    secondaryColor: Color(0xFF4A148C), // Deep Royal Purple
    glowColor: Color(0xFFE1BEE7), // Neon Violet
    eyeColor: Color(0xFFFFD54F), // Amber Gold
    sparkColor: Color(0xFFBA68C8), // Violet Glow
    headFeature: MascotHeadFeature.crescentCrown,
    voicePitch: 0.9,
  );

  static const MascotCharacter volta = MascotCharacter(
    id: MascotId.volta,
    name: 'Volta',
    emoji: '⚡🔥',
    title: 'The Hype Dynamo',
    tagline: 'MAXIMUM SPEED! ABSOLUTE CINEMA!',
    description:
        'A high-octane flame dynamo who thrives on speed runs, combo streaks, and Match Madness frenzy.',
    primaryColor: Color(0xFFFFB300), // Vivid Amber
    secondaryColor: Color(0xFFFF6D00), // Blazing Orange
    glowColor: Color(0xFFFFF59D), // Solar Flare
    eyeColor: Color(0xFFD50000), // Crimson
    sparkColor: Color(0xFFFF3D00), // Flame Spark
    headFeature: MascotHeadFeature.flameSpikes,
    voicePitch: 1.3,
  );

  static const MascotCharacter kora = MascotCharacter(
    id: MascotId.kora,
    name: 'Kora',
    emoji: '🌿💎',
    title: 'The Zen Sage',
    tagline: 'Breathe. Repetition creates clarity.',
    description:
        'A serene emerald nature sprite who helps you embrace mistakes as essential stepping stones to fluency.',
    primaryColor: Color(0xFF00E676), // Emerald Green
    secondaryColor: Color(0xFF004D40), // Deep Forest Teal
    glowColor: Color(0xFFA7FFEB), // Mint Leaf
    eyeColor: Color(0xFF1B5E20), // Pure Jade
    sparkColor: Color(0xFF69F0AE), // Zen Sparkle
    headFeature: MascotHeadFeature.zenLeaf,
    voicePitch: 0.85,
  );

  static const MascotCharacter boba = MascotCharacter(
    id: MascotId.boba,
    name: 'Boba',
    emoji: '🫧🧁',
    title: 'The Cheerful Novice',
    tagline: 'Yay! High five! You\'re doing great! ✋',
    description:
        'A lovable, bouncy pink bubble sprite who celebrates every small win with infectious enthusiasm.',
    primaryColor: Color(0xFFFF80AB), // Bubble Rose
    secondaryColor: Color(0xFFF50057), // Strawberry Pink
    glowColor: Color(0xFFFFD180), // Soft Peach
    eyeColor: Color(0xFF4E342E), // Warm Cocoa
    sparkColor: Color(0xFFFF4081), // Berry Bubble
    headFeature: MascotHeadFeature.bubbleBlush,
    voicePitch: 1.25,
  );

  static const List<MascotCharacter> allMascots = [
    pede,
    nyx,
    volta,
    kora,
    boba,
  ];

  static MascotCharacter fromId(MascotId id) {
    switch (id) {
      case MascotId.pede:
        return pede;
      case MascotId.nyx:
        return nyx;
      case MascotId.volta:
        return volta;
      case MascotId.kora:
        return kora;
      case MascotId.boba:
        return boba;
    }
  }

  static MascotCharacter fromString(String? idStr) {
    if (idStr == null) return pede;
    try {
      final id = MascotId.values.firstWhere(
        (m) => m.name.toLowerCase() == idStr.trim().toLowerCase(),
        orElse: () => MascotId.pede,
      );
      return fromId(id);
    } catch (_) {
      return pede;
    }
  }
}
