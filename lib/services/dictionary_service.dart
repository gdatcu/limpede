class WordHint {
  final String original;
  final String translation;
  final String? partOfSpeech;
  final String? grammarTip;

  const WordHint({
    required this.original,
    required this.translation,
    this.partOfSpeech,
    this.grammarTip,
  });
}

class DictionaryService {
  static final Map<String, Map<String, WordHint>> _dictionary = {
    // Spanish Hints
    'es': {
      'hola': const WordHint(original: 'hola', translation: 'hello / hi', partOfSpeech: 'interjection'),
      'cómo': const WordHint(original: 'cómo', translation: 'how', partOfSpeech: 'adverb'),
      'estás': const WordHint(original: 'estás', translation: 'you are (estar)', partOfSpeech: 'verb (informal)'),
      'buenos': const WordHint(original: 'buenos', translation: 'good', partOfSpeech: 'adjective (masc. plural)'),
      'días': const WordHint(original: 'días', translation: 'days / morning', partOfSpeech: 'noun'),
      'gracias': const WordHint(original: 'gracias', translation: 'thanks / thank you', partOfSpeech: 'interjection'),
      'muchas': const WordHint(original: 'muchas', translation: 'many / very much', partOfSpeech: 'adjective'),
      'mucho': const WordHint(original: 'mucho', translation: 'much / a lot', partOfSpeech: 'adjective'),
      'gusto': const WordHint(original: 'gusto', translation: 'pleasure / taste', partOfSpeech: 'noun'),
      'quisiera': const WordHint(original: 'quisiera', translation: 'I would like', partOfSpeech: 'verb (polite conditional)'),
      'un': const WordHint(original: 'un', translation: 'a / an', partOfSpeech: 'article (masculine)'),
      'una': const WordHint(original: 'una', translation: 'a / an', partOfSpeech: 'article (feminine)'),
      'café': const WordHint(original: 'café', translation: 'coffee', partOfSpeech: 'noun'),
      'por': const WordHint(original: 'por', translation: 'for / please', partOfSpeech: 'preposition'),
      'favor': const WordHint(original: 'favor', translation: 'favor', partOfSpeech: 'noun'),
      'dónde': const WordHint(original: 'dónde', translation: 'where', partOfSpeech: 'adverb'),
      'está': const WordHint(original: 'está', translation: 'is / located', partOfSpeech: 'verb (estar)'),
      'el': const WordHint(original: 'el', translation: 'the', partOfSpeech: 'definite article (masculine)'),
      'la': const WordHint(original: 'la', translation: 'the', partOfSpeech: 'definite article (feminine)'),
      'restaurante': const WordHint(original: 'restaurante', translation: 'restaurant', partOfSpeech: 'noun'),
      'tengo': const WordHint(original: 'tengo', translation: 'I have (tener)', partOfSpeech: 'verb (present)'),
      'años': const WordHint(original: 'años', translation: 'years', partOfSpeech: 'noun'),
      'de': const WordHint(original: 'de', translation: 'of / from', partOfSpeech: 'preposition'),
      'experiencia': const WordHint(original: 'experiencia', translation: 'experience', partOfSpeech: 'noun'),
      'en': const WordHint(original: 'en', translation: 'in / on', partOfSpeech: 'preposition'),
      'programación': const WordHint(original: 'programación', translation: 'programming / coding', partOfSpeech: 'noun'),
    },

    // French Hints
    'fr': {
      'bonjour': const WordHint(original: 'bonjour', translation: 'hello / good morning', partOfSpeech: 'interjection'),
      'comment': const WordHint(original: 'comment', translation: 'how', partOfSpeech: 'adverb'),
      'allez-vous': const WordHint(original: 'allez-vous', translation: 'are you doing', partOfSpeech: 'verb (formal)'),
      'allez': const WordHint(original: 'allez', translation: 'go / are (aller)', partOfSpeech: 'verb'),
      'vous': const WordHint(original: 'vous', translation: 'you', partOfSpeech: 'pronoun (formal/plural)'),
      'bonsoir': const WordHint(original: 'bonsoir', translation: 'good evening', partOfSpeech: 'interjection'),
      'merci': const WordHint(original: 'merci', translation: 'thank you', partOfSpeech: 'interjection'),
      'beaucoup': const WordHint(original: 'beaucoup', translation: 'very much / a lot', partOfSpeech: 'adverb'),
      'un': const WordHint(original: 'un', translation: 'a / an', partOfSpeech: 'article (masculine)'),
      'une': const WordHint(original: 'une', translation: 'a / an', partOfSpeech: 'article (feminine)'),
      'café': const WordHint(original: 'café', translation: 'coffee', partOfSpeech: 'noun'),
      'au': const WordHint(original: 'au', translation: 'with / to the', partOfSpeech: 'preposition'),
      'lait': const WordHint(original: 'lait', translation: 'milk', partOfSpeech: 'noun'),
      's\'il': const WordHint(original: 's\'il', translation: 'if it', partOfSpeech: 'conjunction'),
      'plaît': const WordHint(original: 'plaît', translation: 'pleases (plaire)', partOfSpeech: 'verb'),
    },

    // German Hints
    'de': {
      'hallo': const WordHint(original: 'hallo', translation: 'hello', partOfSpeech: 'interjection'),
      'wie': const WordHint(original: 'wie', translation: 'how', partOfSpeech: 'adverb'),
      'geht': const WordHint(original: 'geht', translation: 'goes (gehen)', partOfSpeech: 'verb'),
      'es': const WordHint(original: 'es', translation: 'it', partOfSpeech: 'pronoun'),
      'dir': const WordHint(original: 'dir', translation: 'you (dative)', partOfSpeech: 'pronoun'),
      'guten': const WordHint(original: 'guten', translation: 'good', partOfSpeech: 'adjective (accusative)'),
      'morgen': const WordHint(original: 'morgen', translation: 'morning / tomorrow', partOfSpeech: 'noun'),
      'tag': const WordHint(original: 'tag', translation: 'day', partOfSpeech: 'noun'),
      'abend': const WordHint(original: 'abend', translation: 'evening', partOfSpeech: 'noun'),
      'danke': const WordHint(original: 'danke', translation: 'thanks / thank you', partOfSpeech: 'interjection'),
      'sehr': const WordHint(original: 'sehr', translation: 'very', partOfSpeech: 'adverb'),
      'bitte': const WordHint(original: 'bitte', translation: 'please / you are welcome', partOfSpeech: 'interjection'),
      'einen': const WordHint(original: 'einen', translation: 'a / an (acc)', partOfSpeech: 'article'),
      'kaffee': const WordHint(original: 'kaffee', translation: 'coffee', partOfSpeech: 'noun'),
    },

    // Romanian Hints
    'ro': {
      'bună': const WordHint(original: 'bună', translation: 'hello / good', partOfSpeech: 'interjection'),
      'ziua': const WordHint(original: 'ziua', translation: 'day', partOfSpeech: 'noun'),
      'ce': const WordHint(original: 'ce', translation: 'what', partOfSpeech: 'pronoun'),
      'faci': const WordHint(original: 'faci', translation: 'you do / you are doing', partOfSpeech: 'verb'),
      'mulțumesc': const WordHint(original: 'mulțumesc', translation: 'thank you', partOfSpeech: 'verb'),
      'mult': const WordHint(original: 'mult', translation: 'much / a lot', partOfSpeech: 'adverb'),
      'o': const WordHint(original: 'o', translation: 'a / an (fem)', partOfSpeech: 'article'),
      'un': const WordHint(original: 'un', translation: 'a / an (masc)', partOfSpeech: 'article'),
      'cafea': const WordHint(original: 'cafea', translation: 'coffee', partOfSpeech: 'noun'),
      'vă': const WordHint(original: 'vă', translation: 'you (polite)', partOfSpeech: 'pronoun'),
      'rog': const WordHint(original: 'rog', translation: 'please / I beg', partOfSpeech: 'verb'),
      'unde': const WordHint(original: 'unde', translation: 'where', partOfSpeech: 'adverb'),
      'este': const WordHint(original: 'este', translation: 'is', partOfSpeech: 'verb (a fi)'),
    },

    // English Hints
    'en': {
      'hello': const WordHint(original: 'hello', translation: 'salut / hola / bonjour', partOfSpeech: 'greeting'),
      'how': const WordHint(original: 'how', translation: 'cum / cómo / comment', partOfSpeech: 'adverb'),
      'are': const WordHint(original: 'are', translation: 'ești / estás / êtes', partOfSpeech: 'verb (be)'),
      'you': const WordHint(original: 'you', translation: 'tu / usted / vous', partOfSpeech: 'pronoun'),
      'good': const WordHint(original: 'good', translation: 'bun / bueno / bon', partOfSpeech: 'adjective'),
      'morning': const WordHint(original: 'morning', translation: 'dimineață / mañana / matin', partOfSpeech: 'noun'),
      'thank': const WordHint(original: 'thank', translation: 'mulțumesc / gracias / merci', partOfSpeech: 'verb'),
      'very': const WordHint(original: 'very', translation: 'foarte / muy / très', partOfSpeech: 'adverb'),
      'much': const WordHint(original: 'much', translation: 'mult / mucho / beaucoup', partOfSpeech: 'adverb'),
      'coffee': const WordHint(original: 'coffee', translation: 'cafea / café / kaffee', partOfSpeech: 'noun'),
      'please': const WordHint(original: 'please', translation: 'vă rog / por favor / s\'il vous plaît', partOfSpeech: 'adverb'),
      'where': const WordHint(original: 'where', translation: 'unde / dónde / où', partOfSpeech: 'adverb'),
      'is': const WordHint(original: 'is', translation: 'este / está / ist', partOfSpeech: 'verb (be)'),
      'the': const WordHint(original: 'the', translation: 'articol hotărât', partOfSpeech: 'article'),
    },
  };

  static String cleanToken(String token) {
    return token
        .toLowerCase()
        .replaceAll(RegExp(r'[^\p{L}\p{N}\-]', unicode: true), '')
        .trim();
  }

  static WordHint? lookup(String word, String languageCode) {
    final langKey = languageCode.trim().toLowerCase().substring(0, 2);
    final cleaned = cleanToken(word);
    if (cleaned.isEmpty) return null;

    final langDict = _dictionary[langKey];
    if (langDict != null && langDict.containsKey(cleaned)) {
      return langDict[cleaned];
    }

    // Default generic hint if word not in mini-dictionary
    return WordHint(
      original: cleaned,
      translation: 'Tap to learn "$cleaned"',
      partOfSpeech: 'word',
    );
  }
}
