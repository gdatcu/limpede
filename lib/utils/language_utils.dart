import '../models/srs_models.dart';

class LanguageUtils {
  /// Map of full language names to 2-letter ISO 639-1 language codes.
  static const Map<String, String> _languageNameToCodeMap = {
    'german': 'de',
    'french': 'fr',
    'spanish': 'es',
    'italian': 'it',
    'romanian': 'ro',
    'portuguese': 'pt',
    'russian': 'ru',
    'japanese': 'ja',
    'english': 'en',
  };

  /// Map of 2-letter ISO 639-1 language codes to full display names.
  static const Map<String, String> _languageCodeToNameMap = {
    'de': 'German',
    'fr': 'French',
    'es': 'Spanish',
    'it': 'Italian',
    'ro': 'Romanian',
    'pt': 'Portuguese',
    'ru': 'Russian',
    'ja': 'Japanese',
    'en': 'English',
  };

  /// Normalizes any language input (name or code) into a standard 2-letter code.
  /// 
  /// Example:
  /// - `normalizeLanguageCode('German')` -> `'de'`
  /// - `normalizeLanguageCode('DE')` -> `'de'`
  /// - `normalizeLanguageCode('de')` -> `'de'`
  static String normalizeLanguageCode(String input) {
    final cleanInput = input.trim().toLowerCase();
    if (_languageNameToCodeMap.containsKey(cleanInput)) {
      return _languageNameToCodeMap[cleanInput]!;
    }
    if (_languageCodeToNameMap.containsKey(cleanInput)) {
      return cleanInput;
    }
    // Fallback: default to 'de' if unrecognized
    return 'de';
  }

  /// Converts a language input into a full clean display name.
  static String getLanguageDisplayName(String input) {
    final code = normalizeLanguageCode(input);
    return _languageCodeToNameMap[code] ?? 'German';
  }

  /// Returns sample words for distractors in fallback option generators.
  static List<String> getFallbackDistractors(String targetLanguage) => getSampleWords(targetLanguage);

  static List<String> getSampleWords(String targetLanguage) {
    final code = normalizeLanguageCode(targetLanguage);
    switch (code) {
      case 'de':
        return [
          'Vielen Dank',
          'Auf Wiedersehen',
          'Guten Morgen',
          'Bitte',
          'Freut mich',
          'Wie gehts?',
        ];
      case 'fr':
        return [
          'Merci beaucoup',
          'Au revoir',
          'Bonjour',
          'S\'il vous plaît',
          'Enchanté',
          'Comment ça va?',
        ];
      case 'ro':
        return [
          'Mulțumesc mult',
          'La revedere',
          'Bună dimineața',
          'Vă rog',
          'Încântat de cunoștință',
          'Ce mai faci?',
        ];
      case 'it':
        return [
          'Grazie mille',
          'Arrivederci',
          'Buongiorno',
          'Per favore',
          'Piacere di conoscerti',
          'Come stai?',
        ];
      case 'pt':
        return [
          'Muito obrigado',
          'Tchau',
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
          grammarNotes: '“Wie geht es dir?” is informal in German.',
        ),
        SentencePair(
          id: 'de_fb_2',
          sourceText: 'Good morning!',
          targetText: 'Guten Morgen!',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Standard morning greeting in German.',
        ),
        SentencePair(
          id: 'de_fb_3',
          sourceText: 'My name is Alex.',
          targetText: 'Ich heiße Alex.',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Ich heiße” means I am called.',
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
        SentencePair(
          id: 'de_fb_6',
          sourceText: 'Where is the train station?',
          targetText: 'Wo ist der Bahnhof?',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Wo ist” means where is.',
        ),
        SentencePair(
          id: 'de_fb_7',
          sourceText: 'I would like a coffee, please.',
          targetText: 'Ich hätte gerne einen Kaffee, bitte.',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Polite ordering phrasing in German.',
        ),
        SentencePair(
          id: 'de_fb_8',
          sourceText: 'Goodbye, see you tomorrow!',
          targetText: 'Auf Wiedersehen, bis morgen!',
          languageCode: 'de',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Bis morgen” means see you tomorrow.',
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
        SentencePair(
          id: 'fr_fb_4',
          sourceText: 'Where is the restaurant?',
          targetText: 'Où est le restaurant ?',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Où est” means where is.',
        ),
        SentencePair(
          id: 'fr_fb_5',
          sourceText: 'I would like a coffee, please.',
          targetText: 'Je voudrais un café, s\'il vous plaît.',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Je voudrais” is polite French for I would like.',
        ),
        SentencePair(
          id: 'fr_fb_6',
          sourceText: 'Goodbye, see you tomorrow!',
          targetText: 'Au revoir, à demain !',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“À demain” means see you tomorrow.',
        ),
        SentencePair(
          id: 'fr_fb_7',
          sourceText: 'Nice to meet you.',
          targetText: 'Enchanté de faire votre connaissance.',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Formal French greeting upon meeting someone.',
        ),
        SentencePair(
          id: 'fr_fb_8',
          sourceText: 'Have a nice day!',
          targetText: 'Bonne journée !',
          languageCode: 'fr',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Friendly daytime parting phrase.',
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
        SentencePair(
          id: 'ro_fb_4',
          sourceText: 'My name is Alex.',
          targetText: 'Mă numesc Alex.',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Mă numesc” means I call myself.',
        ),
        SentencePair(
          id: 'ro_fb_5',
          sourceText: 'Where is the hotel?',
          targetText: 'Unde este hotelul?',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Unde este” means where is.',
        ),
        SentencePair(
          id: 'ro_fb_6',
          sourceText: 'Goodbye, see you tomorrow!',
          targetText: 'La revedere, pe mâine!',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Pe mâine” means see you tomorrow.',
        ),
        SentencePair(
          id: 'ro_fb_7',
          sourceText: 'Nice to meet you!',
          targetText: 'Încântat de cunoștință!',
          languageCode: 'ro',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Polite Romanian greeting.',
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
          grammarNotes: '“¿Cómo estás?” is informal in Spanish.',
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
        SentencePair(
          id: 'es_fb_3',
          sourceText: 'My name is Alex.',
          targetText: 'Me llamo Alex.',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Me llamo” means I call myself.',
        ),
        SentencePair(
          id: 'es_fb_4',
          sourceText: 'Thank you very much!',
          targetText: '¡Muchas gracias!',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Expressing gratitude in Spanish.',
        ),
        SentencePair(
          id: 'es_fb_5',
          sourceText: 'Where is the beach?',
          targetText: '¿Dónde está la playa?',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“¿Dónde está?” means where is.',
        ),
        SentencePair(
          id: 'es_fb_6',
          sourceText: 'Goodbye, see you tomorrow!',
          targetText: '¡Hasta luego, hasta mañana!',
          languageCode: 'es',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Common farewell in Spanish.',
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
          grammarNotes: '“Come stai?” is informal in Italian.',
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
          grammarNotes: '“Mi chiamo” means I call myself.',
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
          grammarNotes: '“Mille” means a thousand.',
        ),
        SentencePair(
          id: 'it_fb_6',
          sourceText: 'Where is the station?',
          targetText: 'Dov\'è la stazione?',
          languageCode: 'it',
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: '“Dov\'è” means where is.',
        ),
      ];
    } else {
      defaultPairs = [
        SentencePair(
          id: '${code}_fb_1',
          sourceText: 'Hello, how are you?',
          targetText: 'Hello, how are you?',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Standard greeting.',
        ),
        SentencePair(
          id: '${code}_fb_2',
          sourceText: 'Good morning!',
          targetText: 'Good morning!',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Morning greeting.',
        ),
        SentencePair(
          id: '${code}_fb_3',
          sourceText: 'Thank you very much!',
          targetText: 'Thank you very much!',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Expressing gratitude.',
        ),
        SentencePair(
          id: '${code}_fb_4',
          sourceText: 'My name is Alex.',
          targetText: 'My name is Alex.',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Personal introduction.',
        ),
        SentencePair(
          id: '${code}_fb_5',
          sourceText: 'Where is the nearest cafe?',
          targetText: 'Where is the nearest cafe?',
          languageCode: code,
          difficultyLevel: 'A1',
          topicCategory: topicCategory,
          grammarNotes: 'Asking for directions.',
        ),
      ];
    }

    return defaultPairs.take(limit).toList();
  }
}
