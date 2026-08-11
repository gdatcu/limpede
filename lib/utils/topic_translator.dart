class TopicTranslator {
  // 1. UNIT PREFIXES (The Headers)
  static const Map<String, Map<String, String>> _unitTranslations = {
    'Basics': {
      'ro': 'Noțiuni de bază',
      'fr': 'Bases',
      'de': 'Grundlagen',
    },
    'Food': {
      'ro': 'Mâncare și Băuturi',
      'fr': 'Nourriture',
      'de': 'Essen und Trinken',
    },
    'Family': {
      'ro': 'Familie',
      'fr': 'Famille',
      'de': 'Familie',
    },
    'Home': {
      'ro': 'Acasă',
      'fr': 'Maison',
      'de': 'Zuhause',
    },
    'Travel': {
      'ro': 'Călătorii',
      'fr': 'Voyage',
      'de': 'Reisen',
    },
    'Shopping': {
      'ro': 'Cumpărături',
      'fr': 'Shopping',
      'de': 'Einkaufen',
    },
    'Weather': {
      'ro': 'Vreme',
      'fr': 'Météo',
      'de': 'Wetter',
    },
    'Health': {
      'ro': 'Sănătate',
      'fr': 'Santé',
      'de': 'Gesundheit',
    },
    'Routine': {
      'ro': 'Rutină zilnică',
      'fr': 'Routine',
      'de': 'Alltag',
    },
    'Hobbies': {
      'ro': 'Hobby-uri',
      'fr': 'Loisirs',
      'de': 'Hobbys',
    },
    'Work': {
      'ro': 'Muncă',
      'fr': 'Travail',
      'de': 'Arbeit',
    },
    'Memories': {
      'ro': 'Amintiri',
      'fr': 'Souvenirs',
      'de': 'Erinnerungen',
    },
    'Opinions': {
      'ro': 'Opinii',
      'fr': 'Opinions',
      'de': 'Meinungen',
    },
    'Romance': {
      'ro': 'Romantic',
      'fr': 'Romance',
      'de': 'Romantik',
    },
    'Tech': {
      'ro': 'Tehnologie',
      'fr': 'Technologie',
      'de': 'Technologie',
    },
    'Education': {
      'ro': 'Educație',
      'fr': 'Éducation',
      'de': 'Bildung',
    },
    'Society': {
      'ro': 'Societate',
      'fr': 'Société',
      'de': 'Gesellschaft',
    },
    'Finance': {
      'ro': 'Finanțe',
      'fr': 'Finances',
      'de': 'Finanzen',
    },
    'Idioms': {
      'ro': 'Expresii',
      'fr': 'Expressions',
      'de': 'Redewendungen',
    },
    'Specialized': {
      'ro': 'Specializat',
      'fr': 'Spécialisé',
      'de': 'Spezialisiert',
    },
  };

  // 2. NODE SUFFIXES (The Circular Buttons)
  static const Map<String, Map<String, String>> _nodeTranslations = {
    // Basics
    'Saying hello and goodbye': {
      'ro': 'Saluturi și despărțiri',
      'fr': 'Dire bonjour et au revoir',
      'de': 'Begrüßung und Verabschiedung',
    },
    'Introducing yourself and your age': {
      'ro': 'Prezentare și vârstă',
      'fr': 'Se présenter',
      'de': 'Sich vorstellen',
    },
    'Saying please, thank you, and sorry': {
      'ro': 'Politețe',
      'fr': 'Politesse',
      'de': 'Höflichkeit',
    },
    'Numbers 1 through 100': {
      'ro': 'Numere 1-100',
      'fr': 'Nombres 1-100',
      'de': 'Zahlen 1-100',
    },
    'Days of the week and months': {
      'ro': 'Zile și luni',
      'fr': 'Jours et mois',
      'de': 'Tage und Monate',
    },
    'Telling the time': {
      'ro': 'Timpul și ora',
      'fr': 'Dire l\'heure',
      'de': 'Uhrzeit',
    },
    'Basic colors and shapes': {
      'ro': 'Culori și forme',
      'fr': 'Couleurs et formes',
      'de': 'Farben und Formen',
    },
    
    // Food
    'Ordering a coffee or tea': {
      'ro': 'Comandarea unei cafele/ceai',
      'fr': 'Commander un café/thé',
      'de': 'Kaffee/Tee bestellen',
    },
    'Asking for the menu': {
      'ro': 'Cererea meniului',
      'fr': 'Demander le menu',
      'de': 'Nach der Speisekarte fragen',
    },
    'Paying the bill at a restaurant': {
      'ro': 'Plata notei',
      'fr': 'Payer l\'addition',
      'de': 'Die Rechnung bezahlen',
    },
    'Naming basic fruits and vegetables': {
      'ro': 'Fructe și legume',
      'fr': 'Fruits et légumes',
      'de': 'Obst und Gemüse',
    },
    'Discussing food allergies': {
      'ro': 'Alergii alimentare',
      'fr': 'Allergies alimentaires',
      'de': 'Lebensmittelallergien',
    },
    'Grocery shopping for ingredients': {
      'ro': 'Cumpărături alimentare',
      'fr': 'Faire les courses',
      'de': 'Lebensmitteleinkauf',
    },

    // Travel
    'Asking where the bathroom is': {
      'ro': 'Unde este baia?',
      'fr': 'Où sont les toilettes ?',
      'de': 'Wo ist die Toilette?',
    },
    'Buying a train or bus ticket': {
      'ro': 'Bilete de tren/autobuz',
      'fr': 'Acheter un billet',
      'de': 'Fahrkarten kaufen',
    },
    'Asking for basic directions (left/right)': {
      'ro': 'Direcții',
      'fr': 'Demander son chemin',
      'de': 'Nach dem Weg fragen',
    },
    'Checking into a hotel': {
      'ro': 'Cazarea la hotel',
      'fr': 'Arrivée à l\'hôtel',
      'de': 'Im Hotel einchecken',
    },
    'Navigating the airport and security': {
      'ro': 'La aeroport',
      'fr': 'À l\'aéroport',
      'de': 'Am Flughafen',
    },
    'Dealing with lost luggage at the airport': {
      'ro': 'Bagaje pierdute',
      'fr': 'Bagages perdus',
      'de': 'Verlorenes Gepäck',
    },

    // Work / Tech / Society (Examples)
    'Naming basic professions': {
      'ro': 'Profesii',
      'fr': 'Professions',
      'de': 'Berufe',
    },
    'Preparing for a job interview': {
      'ro': 'Interviu de angajare',
      'fr': 'Entretien d\'embauche',
      'de': 'Vorstellungsgespräch',
    },
    'Sending professional emails': {
      'ro': 'Emailuri profesionale',
      'fr': 'E-mails professionnels',
      'de': 'Geschäftliche E-Mails',
    },
    'Using a smartphone and apps': {
      'ro': 'Smartphone și aplicații',
      'fr': 'Smartphone et applis',
      'de': 'Smartphone und Apps',
    },
    'Browsing the internet': {
      'ro': 'Navigare pe internet',
      'fr': 'Naviguer sur Internet',
      'de': 'Im Internet surfen',
    }
  };

  /// Translates the Unit Prefix (e.g., "Basics")
  static String translateUnit(String englishUnit, String langCode) {
    if (langCode == 'en') return englishUnit;
    return _unitTranslations[englishUnit]?[langCode] ?? englishUnit;
  }

  /// Translates the Node Suffix (e.g., "Saying hello and goodbye")
  static String translateNode(String englishNode, String langCode) {
    if (langCode == 'en') return englishNode;
    return _nodeTranslations[englishNode]?[langCode] ?? englishNode;
  }

  /// Translates a full category (e.g. "Basics: Saying hello and goodbye") or standalone topic string.
  static String translateCategory(String englishCategory, String langCode) {
    if (langCode == 'en') return englishCategory;
    if (englishCategory.contains(':')) {
      final parts = englishCategory.split(':');
      final prefix = parts[0].trim();
      final suffix = parts.sublist(1).join(':').trim();
      final translatedPrefix = translateUnit(prefix, langCode);
      final translatedSuffix = translateNode(suffix, langCode);
      return '$translatedPrefix: $translatedSuffix';
    }
    final unitRes = translateUnit(englishCategory.trim(), langCode);
    if (unitRes != englishCategory.trim()) return unitRes;
    return translateNode(englishCategory.trim(), langCode);
  }
}