import 'language_utils.dart';

/// Utility class for translating dynamic Supabase topic_category titles
/// (e.g., "Basics: Saying hello and goodbye") into the user's native language.
class TopicTranslator {
  /// Dictionary mapping for Unit Names (Prefixes).
  static final Map<String, Map<String, String>> _unitMap = {
    'basics': {
      'ro': 'Noțiuni de bază',
      'fr': 'Bases',
      'de': 'Grundlagen',
      'es': 'Básicos',
      'it': 'Fondamenti',
      'pt': 'Básicos',
      'ru': 'Основы',
      'ja': '基本',
    },
    'food': {
      'ro': 'Mâncare',
      'fr': 'Nourriture',
      'de': 'Essen',
      'es': 'Comida',
      'it': 'Cibo',
      'pt': 'Comida',
      'ru': 'Еда',
      'ja': '食べ物',
    },
    'travel': {
      'ro': 'Călătorii',
      'fr': 'Voyage',
      'de': 'Reisen',
      'es': 'Viajes',
      'it': 'Viaggi',
      'pt': 'Viagens',
      'ru': 'Путешествия',
      'ja': '旅行',
    },
    'family': {
      'ro': 'Familie',
      'fr': 'Famille',
      'de': 'Familie',
      'es': 'Familia',
      'it': 'Famiglia',
      'pt': 'Família',
      'ru': 'Семья',
      'ja': '家族',
    },
    'education': {
      'ro': 'Educație',
      'fr': 'Éducation',
      'de': 'Bildung',
      'es': 'Educación',
      'it': 'Istruzione',
      'pt': 'Educação',
      'ru': 'Образование',
      'ja': '教育',
    },
    'work': {
      'ro': 'Muncă',
      'fr': 'Travail',
      'de': 'Arbeit',
      'es': 'Trabajo',
      'it': 'Lavoro',
      'pt': 'Trabalho',
      'ru': 'Работа',
      'ja': '仕事',
    },
    'shopping': {
      'ro': 'Cumpărături',
      'fr': 'Achats',
      'de': 'Einkaufen',
      'es': 'Compras',
      'it': 'Acquisti',
      'pt': 'Compras',
      'ru': 'Покупки',
      'ja': '買い物',
    },
    'health': {
      'ro': 'Sănătate',
      'fr': 'Santé',
      'de': 'Gesundheit',
      'es': 'Salud',
      'it': 'Salute',
      'pt': 'Saúde',
      'ru': 'Здоровье',
      'ja': '健康',
    },
  };

  /// Dictionary mapping for Node Names (Suffixes).
  static final Map<String, Map<String, String>> _nodeMap = {
    'saying hello and goodbye': {
      'ro': 'Saluturi și despărțiri',
      'fr': 'Dire bonjour et au revoir',
      'de': 'Begrüßung und Verabschiedung',
      'es': 'Decir hola y adiós',
      'it': 'Salutare e congedarsi',
      'pt': 'Dizer olá e adeus',
      'ru': 'Приветствие и прощание',
      'ja': '挨拶とお別れ',
    },
    'introducing yourself and your age': {
      'ro': 'Prezentare și vârstă',
      'fr': 'Se présenter et dire son âge',
      'de': 'Sich vorstellen und Alter',
      'es': 'Presentarse y edad',
      'it': 'Presentarsi e l\'età',
      'pt': 'Apresentar-se e idade',
      'ru': 'Знакомство и возраст',
      'ja': '自己紹介と年齢',
    },
    'ordering a coffee or tea': {
      'ro': 'Comandarea unei cafele sau ceai',
      'fr': 'Commander un café ou un thé',
      'de': 'Kaffee oder Tee bestellen',
      'es': 'Pedir un café o té',
      'it': 'Ordinare un caffè o un tè',
      'pt': 'Pedir um café ou chá',
      'ru': 'Заказ кофе или чая',
      'ja': 'コーヒーや紅茶を注文する',
    },
    'asking for directions': {
      'ro': 'Solicitarea indicațiilor',
      'fr': 'Demander son chemin',
      'de': 'Nach dem Weg fragen',
      'es': 'Pedir direcciones',
      'it': 'Chiedere indicazioni',
      'pt': 'Pedir direções',
      'ru': 'Задать направление',
      'ja': '道を尋ねる',
    },
    'talking about family members': {
      'ro': 'Despre membrii familiei',
      'fr': 'Parler de sa famille',
      'de': 'Über Familienmitglieder sprechen',
      'es': 'Hablar sobre la familia',
      'it': 'Parlare della famiglia',
      'pt': 'Falar sobre a família',
      'ru': 'Разговор о семье',
      'ja': '家族について話す',
    },
    'asking for the check': {
      'ro': 'Cere nota de plată',
      'fr': 'Demander l\'addition',
      'de': 'Nach der Rechnung fragen',
      'es': 'Pedir la cuenta',
      'it': 'Chiedere il conto',
      'pt': 'Pedir a conta',
      'ru': 'Просить счет',
      'ja': 'お会計を頼む',
    },
    'booking a hotel room': {
      'ro': 'Rezervarea unei camere de hotel',
      'fr': 'Réserver une chambre d\'hôtel',
      'de': 'Ein Hotelzimmer buchen',
      'es': 'Reservar una habitación de hotel',
      'it': 'Prenotare una camera d\'albergo',
      'pt': 'Reservar um quarto de hotel',
      'ru': 'Бронирование номера в отеле',
      'ja': 'ホテルを予約する',
    },
  };

  /// Translates an English dynamic topic string, unit, or node into the user's native language.
  /// 
  /// Supports "Unit: Node" format (e.g. "Basics: Saying hello and goodbye") as well as standalone strings.
  static String translate(String englishText, String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    if (code == 'en') return englishText;

    if (englishText.contains(':')) {
      final parts = englishText.split(':');
      final prefix = parts[0].trim();
      final suffix = parts.sublist(1).join(':').trim();

      final translatedPrefix = _translateUnit(prefix, code);
      final translatedSuffix = _translateNode(suffix, code);

      return '$translatedPrefix: $translatedSuffix';
    }

    final translatedUnit = _translateUnit(englishText, code);
    if (translatedUnit != englishText) return translatedUnit;

    return _translateNode(englishText, code);
  }

  static String _translateUnit(String unit, String langCode) {
    final key = unit.trim().toLowerCase();
    if (_unitMap.containsKey(key) && _unitMap[key]!.containsKey(langCode)) {
      return _unitMap[key]![langCode]!;
    }
    return unit;
  }

  static String _translateNode(String node, String langCode) {
    final key = node.trim().toLowerCase();
    if (_nodeMap.containsKey(key) && _nodeMap[key]!.containsKey(langCode)) {
      return _nodeMap[key]![langCode]!;
    }
    return node;
  }
}
