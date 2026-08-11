import '../models/srs_models.dart';

class LanguageUtils {
  /// Normalizes target language names to standard ISO 639-1 language codes.
  static String normalizeLanguageCode(String targetLanguage) {
    final lang = targetLanguage.trim().toLowerCase();
    if (lang == 'es' || lang.contains('spanish')) return 'es';
    if (lang == 'fr' || lang.contains('french')) return 'fr';
    if (lang == 'de' || lang.contains('german')) return 'de';
    if (lang == 'it' || lang.contains('italian')) return 'it';
    if (lang == 'ro' || lang.contains('romanian')) return 'ro';
    if (lang == 'pt' || lang.contains('portuguese')) return 'pt';
    if (lang == 'ru' || lang.contains('russian')) return 'ru';
    if (lang == 'ja' || lang.contains('japanese')) return 'ja';
    if (lang == 'tr' || lang.contains('turkish')) return 'tr';
    return lang;
  }

  /// Returns a country flag emoji for display.
  static String getLanguageFlag(String targetLanguage) {
    final code = normalizeLanguageCode(targetLanguage);
    switch (code) {
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      case 'de':
        return '🇩🇪';
      case 'it':
        return '🇮🇹';
      case 'ro':
        return '🇷🇴';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'ja':
        return '🇯🇵';
      case 'tr':
        return '🇹🇷';
      default:
        return '🌐';
    }
  }

  /// Returns language-appropriate distractor options for multiple choice questions.
  static List<String> getFallbackDistractors(String targetLanguage) {
    final code = normalizeLanguageCode(targetLanguage);
    switch (code) {
      case 'de':
        return [
          'Guten Tag',
          'Danke schön',
          'Auf Wiedersehen',
          'Sehr gut',
          'Ja, bitte',
          'Entschuldigung',
          'Bis morgen',
          'Alles klar',
          'Ich heiße Alex',
          'Wie geht es dir?',
        ];
      case 'fr':
        return [
          'Merci beaucoup',
          'Au revoir',
          'S\'il vous plaît',
          'Bonsoir',
          'À demain',
          'Enchanté',
          'Comment ça va?',
          'Bonne journée',
        ];
      case 'it':
        return [
          'Grazie mille',
          'Arrivederci',
          'Buongiorno',
          'Per favore',
          'Piacere',
          'Come stai?',
          'Buona giornata',
          'A presto',
        ];
      case 'ro':
        return [
          'Mulțumesc mult',
          'La revedere',
          'Bună dimineața',
          'Te rog',
          'Încântat',
          'Ce mai faci?',
          'O zi bună',
        ];
      case 'pt':
        return [
          'Muito obrigado',
          'Até logo',
          'Bom dia',
          'Por favor',
          'Prazer em conhecê-lo',
          'Como você está?',
        ];
      case 'ru':
        return [
          'Большое спасибо',
          'До свидания',
          'Доброе утро',
          'Пожалуйста',
          'Очень приятно',
          'Как дела?',
        ];
      case 'ja':
        return [
          'ありがとうございます',
          'さようなら',
          'おはようございます',
          'すみません',
          'はじめまして',
          'お元気ですか？',
        ];
      case 'es':
      default:
        return [
          'Muchas gracias',
          'Hasta luego',
          'Buenos días',
          'Por favor',
          'Mucho gusto',
          '¿Cómo estás?',
        ];
    }
  }

  /// Returns language-appropriate fallback sentence pairs when database queries return empty.
  static List<SentencePair> getFallbackSentencePairs({
    required String topicCategory,
    required String targetLanguage,
    int limit = 10,
  }) {
    final code = normalizeLanguageCode(targetLanguage);
    final cleanTopic = topicCategory.contains(':')
        ? topicCategory.split(':').sublist(1).join(':').trim()
        : topicCategory;

    List<SentencePair> defaultPairs = [];

    if (code == 'de') {
      defaultPairs = [
        SentencePair(
          id: 'de_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Hallo, wie geht es dir?',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Wie geht es dir?” is informal in German, used with friends.',
        ),
        SentencePair(
          id: 'de_fb_2',
          sourceText: 'Good morning!',
          targetText: 'Guten Morgen!',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Standard morning greeting in German until midday.',
        ),
        SentencePair(
          id: 'de_fb_3',
          sourceText: 'My name is Alex.',
          targetText: 'Ich heiße Alex.',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Ich heiße” means I am called in German.',
        ),
        SentencePair(
          id: 'de_fb_4',
          sourceText: 'Nice to meet you.',
          targetText: 'Freut mich, dich kennenzulernen.',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Polite introduction expression in German.',
        ),
        SentencePair(
          id: 'de_fb_5',
          sourceText: 'Thank you very much!',
          targetText: 'Vielen Dank!',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Vielen Dank” is a warm form of thank you.',
        ),
      ];
    } else if (code == 'it') {
      defaultPairs = [
        SentencePair(
          id: 'it_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Ciao, come stai?',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Come stai?” is informal in Italian, used with friends.',
        ),
        SentencePair(
          id: 'it_fb_2',
          sourceText: 'Good morning!',
          targetText: 'Buongiorno!',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Standard Italian morning greeting.',
        ),
        SentencePair(
          id: 'it_fb_3',
          sourceText: 'My name is Marco.',
          targetText: 'Mi chiamo Marco.',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Mi chiamo” means I call myself in Italian.',
        ),
        SentencePair(
          id: 'it_fb_4',
          sourceText: 'Nice to meet you.',
          targetText: 'Piacere di conoscerti.',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Polite Italian introduction.',
        ),
        SentencePair(
          id: 'it_fb_5',
          sourceText: 'Thank you very much!',
          targetText: 'Grazie mille!',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Mille” means a thousand, so thousands of thanks.',
        ),
      ];
    } else if (code == 'fr') {
      defaultPairs = [
        SentencePair(
          id: 'fr_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Bonjour, comment ça va?',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Comment ça va?” is the standard friendly greeting in French.',
        ),
        SentencePair(
          id: 'fr_fb_2',
          sourceText: 'My name is Alex.',
          targetText: 'Je m\'appelle Alex.',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Je m\'appelle” translates to I call myself.',
        ),
        SentencePair(
          id: 'fr_fb_3',
          sourceText: 'Thank you very much!',
          targetText: 'Merci beaucoup!',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Beaucoup” means very much.',
        ),
      ];
    } else if (code == 'ro') {
      defaultPairs = [
        SentencePair(
          id: 'ro_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Bună, ce mai faci?',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Standard friendly greeting in Romanian.',
        ),
        SentencePair(
          id: 'ro_fb_2',
          sourceText: 'Good morning!',
          targetText: 'Bună dimineața!',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Romanian morning greeting.',
        ),
        SentencePair(
          id: 'ro_fb_3',
          sourceText: 'Thank you very much!',
          targetText: 'Mulțumesc mult!',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Expressing gratitude in Romanian.',
        ),
      ];
    } else if (code == 'es') {
      defaultPairs = [
        SentencePair(
          id: 'es_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Hola, ¿cómo estás?',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“¿Cómo estás?” is informal, used with friends in Spanish.',
        ),
        SentencePair(
          id: 'es_fb_2',
          sourceText: 'Good morning!',
          targetText: '¡Buenos días!',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Used until midday in Spanish.',
        ),
      ];
    }

    if (defaultPairs.length < limit) {
      final extraCount = limit - defaultPairs.length;
      for (int i = 0; i < extraCount; i++) {
        defaultPairs.add(SentencePair(
          id: 'fb_${code}_${defaultPairs.length + 1}',
          sourceText: 'Sample phrase ${defaultPairs.length + 1} for $cleanTopic',
          targetText: 'Phrase example ${defaultPairs.length + 1} for $cleanTopic ($targetLanguage)',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Practice phrase for $cleanTopic in $targetLanguage.',
        ));
      }
    }

    return defaultPairs.take(limit).toList();
  }
}
