import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_provider.dart';
import 'user_provider.dart';

part 'topic_provider.g.dart';

class TopicNode {
  final String fullCategory;
  final String unitName;
  final String nodeName;
  final IconData icon;
  final bool isCompleted;
  final bool isLocked;

  const TopicNode({
    required this.fullCategory,
    required this.unitName,
    required this.nodeName,
    required this.icon,
    this.isCompleted = false,
    this.isLocked = true,
  });
}

class TopicUnit {
  final String unitName;
  final int unitNumber;
  final String levelBadge;
  final String description;
  final List<TopicNode> nodes;

  const TopicUnit({
    required this.unitName,
    required this.unitNumber,
    required this.levelBadge,
    required this.description,
    required this.nodes,
  });
}

@riverpod
Future<List<TopicUnit>> topicUnits(
  Ref ref, {
  required String targetLanguage,
}) async {
  final supabaseService = ref.watch(supabaseServiceProvider);
  final completedTopicsAsync = ref.watch(completedTopicsProvider);
  final completedTopics = completedTopicsAsync.maybeWhen(
    data: (set) => set,
    orElse: () => <String>{},
  );

  // Fetch all categories dynamically present in Supabase for this language
  final rawDbCategories = await supabaseService.fetchTopicCategories(
    targetLanguage: targetLanguage,
  );

  final List<Map<String, dynamic>> masterUnitsData = [
    {
      'unitName': 'Basics',
      'levelBadge': 'CEFR A1',
      'description': 'Essential greetings, simple responses, colors, and dates.',
      'topics': [
        'Basics: Saying hello and goodbye',
        'Basics: Introductions and names',
        'Basics: Basic colors and shapes',
        'Basics: Days of the week and months',
      ],
    },
    {
      'unitName': 'Family & Home',
      'levelBadge': 'CEFR A1',
      'description': 'Describe relatives, home life, pets, and relationships.',
      'topics': [
        'Family: Family members and relations',
        'Family: Describing your home',
        'Family: Pets and common animals',
      ],
    },
    {
      'unitName': 'Food & Dining',
      'levelBadge': 'CEFR A2',
      'description': 'Order meals, cafes, ingredients, and dining out.',
      'topics': [
        'Food: Ordering a coffee or tea',
        'Food: At the local restaurant',
        'Food: Groceries and ingredients',
      ],
    },
    {
      'unitName': 'Travel & Transit',
      'levelBadge': 'CEFR A2',
      'description': 'Directions, airport navigation, hotels, and transit.',
      'topics': [
        'Travel: Asking for directions',
        'Travel: At the airport and hotel',
        'Travel: Public transportation',
      ],
    },
    {
      'unitName': 'Education & Study',
      'levelBadge': 'CEFR B1',
      'description': 'Academic conversations, studying, and learning terms.',
      'topics': [
        'Education: School and university terms',
        'Education: Books, reading, and writing',
      ],
    },
    {
      'unitName': 'Work & Career',
      'levelBadge': 'CEFR B1',
      'description': 'Office communication, job roles, and career discussions.',
      'topics': [
        'Work: Office conversation',
        'Work: Job interviews and roles',
      ],
    },
    {
      'unitName': 'Shopping & Market',
      'levelBadge': 'CEFR B2',
      'description': 'Purchasing items, prices, markets, and store terms.',
      'topics': [
        'Shopping: Purchasing items and prices',
        'Shopping: Clothing and sizes',
      ],
    },
    {
      'unitName': 'Health & Wellbeing',
      'levelBadge': 'CEFR B2',
      'description': 'Medical visits, body parts, and wellbeing.',
      'topics': [
        'Health: At the doctor clinic',
        'Health: Body parts and feelings',
      ],
    },
    {
      'unitName': 'General Vocabulary - Final Challenge',
      'levelBadge': 'FINAL BOSS',
      'description': 'Test your overall mastery across the comprehensive vocabulary library.',
      'topics': [
        'General Vocabulary: Core words',
        'General Vocabulary: Advanced fluency challenges',
      ],
    },
  ];

  // Merge any dynamic DB categories into existing or extra master units
  final Set<String> knownTopics = {};
  for (var u in masterUnitsData) {
    knownTopics.addAll((u['topics'] as List).cast<String>());
  }

  for (var cat in rawDbCategories) {
    if (!knownTopics.contains(cat)) {
      if (cat.toLowerCase().startsWith('general vocabulary')) {
        (masterUnitsData.last['topics'] as List).add(cat);
      } else {
        masterUnitsData.first['topics'].add(cat);
      }
    }
  }

  final List<TopicUnit> resultUnits = [];
  int unitCounter = 1;
  bool previousNodeCompleted = true; // First node unlocked by default

  for (final unitMap in masterUnitsData) {
    final String unitName = unitMap['unitName'] as String;
    final String levelBadge = unitMap['levelBadge'] as String;
    final String description = unitMap['description'] as String;
    final List<String> topicList = (unitMap['topics'] as List).cast<String>();

    final List<TopicNode> nodes = [];

    for (final category in topicList) {
      final String nodeName = category.contains(':')
          ? category.split(':').sublist(1).join(':').trim()
          : category.trim();

      final isCompleted = completedTopics.contains(category);
      final isLocked = !previousNodeCompleted;

      nodes.add(TopicNode(
        fullCategory: category,
        unitName: unitName,
        nodeName: nodeName,
        icon: _selectPlayfulIcon(unitName, nodeName),
        isCompleted: isCompleted,
        isLocked: isLocked,
      ));

      // Standard progression: completing current node unlocks next
      previousNodeCompleted = isCompleted;
    }

    resultUnits.add(TopicUnit(
      unitName: unitName,
      unitNumber: unitCounter++,
      levelBadge: levelBadge,
      description: description,
      nodes: nodes,
    ));
  }

  return resultUnits;
}

IconData _selectPlayfulIcon(String unitName, String nodeName) {
  final u = unitName.toLowerCase();
  final n = nodeName.toLowerCase();

  if (u.contains('basic') || n.contains('hello') || n.contains('greet')) {
    return Icons.waving_hand_rounded;
  }
  if (n.contains('intro') || n.contains('name')) {
    return Icons.record_voice_over_rounded;
  }
  if (n.contains('color') || n.contains('shape')) {
    return Icons.palette_rounded;
  }
  if (n.contains('day') || n.contains('month') || n.contains('week')) {
    return Icons.calendar_month_rounded;
  }
  if (u.contains('food') || n.contains('coffee') || n.contains('tea')) {
    return Icons.local_cafe_rounded;
  }
  if (n.contains('restaurant') || n.contains('eat') || n.contains('dine')) {
    return Icons.restaurant_rounded;
  }
  if (u.contains('travel') || n.contains('flight') || n.contains('airport')) {
    return Icons.flight_takeoff_rounded;
  }
  if (n.contains('direction') || n.contains('map')) {
    return Icons.explore_rounded;
  }
  if (u.contains('family') || n.contains('home')) {
    return Icons.family_restroom_rounded;
  }
  if (u.contains('work') || n.contains('job') || n.contains('office')) {
    return Icons.work_rounded;
  }
  if (u.contains('education') || n.contains('school') || n.contains('book')) {
    return Icons.school_rounded;
  }
  if (u.contains('shopping') || n.contains('money') || n.contains('buy')) {
    return Icons.shopping_cart_rounded;
  }
  if (u.contains('health') || n.contains('doctor')) {
    return Icons.medical_services_rounded;
  }
  return Icons.auto_awesome_rounded;
}
