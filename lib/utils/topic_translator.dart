class TopicTranslator {
  // 1. UNIT PREFIXES (The Headers)
  static const Map<String, Map<String, String>> _unitTranslations = {
    'Basics': {
      'ro': 'Noțiuni de bază',
      'fr': 'Bases',
      'de': 'Grundlagen',
      'es': 'Conceptos básicos',
    },
    'Food': {
      'ro': 'Mâncare și Băuturi',
      'fr': 'Nourriture',
      'de': 'Essen und Trinken',
      'es': 'Comida y Bebidas',
    },
    'Family': {
      'ro': 'Familie',
      'fr': 'Famille',
      'de': 'Familie',
      'es': 'Familia',
    },
    'Home': {
      'ro': 'Acasă',
      'fr': 'Maison',
      'de': 'Zuhause',
      'es': 'Hogar',
    },
    'Travel': {
      'ro': 'Călătorii',
      'fr': 'Voyage',
      'de': 'Reisen',
      'es': 'Viajes',
    },
    'Shopping': {
      'ro': 'Cumpărături',
      'fr': 'Shopping',
      'de': 'Einkaufen',
      'es': 'Compras',
    },
    'Weather': {
      'ro': 'Vreme',
      'fr': 'Météo',
      'de': 'Wetter',
      'es': 'Clima',
    },
    'Health': {
      'ro': 'Sănătate',
      'fr': 'Santé',
      'de': 'Gesundheit',
      'es': 'Salud',
    },
    'Routine': {
      'ro': 'Rutină zilnică',
      'fr': 'Routine',
      'de': 'Alltag',
      'es': 'Rutina diaria',
    },
    'Hobbies': {
      'ro': 'Hobby-uri',
      'fr': 'Loisirs',
      'de': 'Hobbys',
      'es': 'Pasatiempos',
    },
    'Work': {
      'ro': 'Muncă',
      'fr': 'Travail',
      'de': 'Arbeit',
      'es': 'Trabajo',
    },
    'Memories': {
      'ro': 'Amintiri',
      'fr': 'Souvenirs',
      'de': 'Erinnerungen',
      'es': 'Recuerdos',
    },
    'Opinions': {
      'ro': 'Opinii',
      'fr': 'Opinions',
      'de': 'Meinungen',
      'es': 'Opiniones',
    },
    'Romance': {
      'ro': 'Romantic',
      'fr': 'Romance',
      'de': 'Romantik',
      'es': 'Romance',
    },
    'Tech': {
      'ro': 'Tehnologie',
      'fr': 'Technologie',
      'de': 'Technologie',
      'es': 'Tecnología',
    },
    'Education': {
      'ro': 'Educație',
      'fr': 'Éducation',
      'de': 'Bildung',
      'es': 'Educación',
    },
    'Society': {
      'ro': 'Societate',
      'fr': 'Société',
      'de': 'Gesellschaft',
      'es': 'Sociedad',
    },
    'Finance': {
      'ro': 'Finanțe',
      'fr': 'Finances',
      'de': 'Finanzen',
      'es': 'Finanzas',
    },
    'Idioms': {
      'ro': 'Expresii',
      'fr': 'Expressions',
      'de': 'Redewendungen',
      'es': 'Modismos',
    },
    'Specialized': {
      'ro': 'Specializat',
      'fr': 'Spécialisé',
      'de': 'Spezialisiert',
      'es': 'Especializado',
    },
    'Family & Home': {
      'ro': 'Familie și Acasă',
      'fr': 'Famille et Maison',
      'de': 'Familie & Zuhause',
      'es': 'Familia y Hogar',
    },
    'Food & Dining': {
      'ro': 'Mâncare și Restaurante',
      'fr': 'Nourriture et Restauration',
      'de': 'Essen & Trinken',
      'es': 'Comida y Restaurantes',
    },
    'Travel & Transit': {
      'ro': 'Călătorii și Transport',
      'fr': 'Voyage et Transports',
      'de': 'Reisen & Verkehr',
      'es': 'Viajes y Transporte',
    },
    'Education & Study': {
      'ro': 'Educație și Studiu',
      'fr': 'Éducation et Études',
      'de': 'Bildung & Studium',
      'es': 'Educación y Estudio',
    },
    'Work & Career': {
      'ro': 'Muncă și Carieră',
      'fr': 'Travail et Carrière',
      'de': 'Arbeit & Karriere',
      'es': 'Trabajo y Carrera',
    },
    'Shopping & Market': {
      'ro': 'Cumpărături și Piață',
      'fr': 'Achats et Marché',
      'de': 'Einkaufen & Markt',
      'es': 'Compras y Mercado',
    },
    'Health & Wellbeing': {
      'ro': 'Sănătate și Bunăstare',
      'fr': 'Santé et Bien-être',
      'de': 'Gesundheit & Wohlbefinden',
      'es': 'Salud y Bienestar',
    },
    'General Vocabulary - Final Challenge': {
      'ro': 'Vocabular General - Provocarea Finală',
      'fr': 'Vocabulaire Général - Défi Final',
      'de': 'Allgemeiner Wortschatz - Letzte Herausforderung',
      'es': 'Vocabulario General - Desafío Final',
    },
    'General Vocabulary': {
      'ro': 'Vocabular General',
      'fr': 'Vocabulaire Général',
      'de': 'Allgemeiner Wortschatz',
      'es': 'Vocabulario General',
    },
  };

  // 2. NODE SUFFIXES (The Circular Buttons)
  static const Map<String, Map<String, String>> _nodeTranslations = {
    // Basics
    'Saying hello and goodbye': {
      'ro': 'Saluturi și despărțiri',
      'fr': 'Dire bonjour et au revoir',
      'de': 'Begrüßung und Verabschiedung',
      'es': 'Saludos y despedidas',
    },
    'Introducing yourself and your age': {
      'ro': 'Prezentare și vârstă',
      'fr': 'Se présenter',
      'de': 'Sich vorstellen',
      'es': 'Presentaciones y edad',
    },
    'Saying please, thank you, and sorry': {
      'ro': 'Politețe',
      'fr': 'Politesse',
      'de': 'Höflichkeit',
      'es': 'Cortesía',
    },
    'Numbers 1 through 100': {
      'ro': 'Numere 1-100',
      'fr': 'Nombres 1-100',
      'de': 'Zahlen 1-100',
      'es': 'Números del 1 al 100',
    },
    'Days of the week and months': {
      'ro': 'Zile și luni',
      'fr': 'Jours et mois',
      'de': 'Tage und Monate',
      'es': 'Días y meses',
    },
    'Telling the time': {
      'ro': 'Timpul și ora',
      'fr': 'Dire l\'heure',
      'de': 'Uhrzeit',
      'es': 'Decir la hora',
    },
    'Basic colors and shapes': {
      'ro': 'Culori și forme',
      'fr': 'Couleurs et formes',
      'de': 'Farben und Formen',
      'es': 'Colores y formas',
    },
    
    // Food
    'Ordering a coffee or tea': {
      'ro': 'Comandarea unei cafele/ceai',
      'fr': 'Commander un café/thé',
      'de': 'Kaffee/Tee bestellen',
      'es': 'Pedir un café o té',
    },
    'Asking for the menu': {
      'ro': 'Cererea meniului',
      'fr': 'Demander le menu',
      'de': 'Nach der Speisekarte fragen',
      'es': 'Pedir el menú',
    },
    'Paying the bill at a restaurant': {
      'ro': 'Plata notei',
      'fr': 'Payer l\'addition',
      'de': 'Die Rechnung bezahlen',
      'es': 'Pagar la cuenta',
    },
    'Naming basic fruits and vegetables': {
      'ro': 'Fructe și legume',
      'fr': 'Fruits et légumes',
      'de': 'Obst und Gemüse',
      'es': 'Frutas y verduras',
    },
    'Discussing food allergies': {
      'ro': 'Alergii alimentare',
      'fr': 'Allergies alimentaires',
      'de': 'Lebensmittelallergien',
      'es': 'Alergias alimentarias',
    },
    'Grocery shopping for ingredients': {
      'ro': 'Cumpărături alimentare',
      'fr': 'Faire les courses',
      'de': 'Lebensmitteleinkauf',
      'es': 'Hacer las compras',
    },

    // Travel
    'Asking where the bathroom is': {
      'ro': 'Unde este baia?',
      'fr': 'Où sont les toilettes ?',
      'de': 'Wo ist die Toilette?',
      'es': 'Preguntar por el baño',
    },
    'Buying a train or bus ticket': {
      'ro': 'Bilete de tren/autobuz',
      'fr': 'Acheter un billet',
      'de': 'Fahrkarten kaufen',
      'es': 'Comprar boletos',
    },
    'Asking for basic directions (left/right)': {
      'ro': 'Direcții',
      'fr': 'Demander son chemin',
      'de': 'Nach dem Weg fragen',
      'es': 'Pedir indicaciones',
    },
    'Checking into a hotel': {
      'ro': 'Cazarea la hotel',
      'fr': 'Arrivée à l\'hôtel',
      'de': 'Im Hotel einchecken',
      'es': 'Registrarse en el hotel',
    },
    'Navigating the airport and security': {
      'ro': 'La aeroport',
      'fr': 'À l\'aéroport',
      'de': 'Am Flughafen',
      'es': 'En el aeropuerto',
    },
    'Dealing with lost luggage at the airport': {
      'ro': 'Bagaje pierdute',
      'fr': 'Bagages perdus',
      'de': 'Verlorenes Gepäck',
      'es': 'Equipaje perdido',
    },

    // Work / Tech / Society (Examples)
    'Naming basic professions': {
      'ro': 'Profesii',
      'fr': 'Professions',
      'de': 'Berufe',
      'es': 'Profesiones',
    },
    'Preparing for a job interview': {
      'ro': 'Interviu de angajare',
      'fr': 'Entretien d\'embauche',
      'de': 'Vorstellungsgespräch',
      'es': 'Entrevista de trabajo',
    },
    'Sending professional emails': {
      'ro': 'Emailuri profesionale',
      'fr': 'E-mails professionnels',
      'de': 'Geschäftliche E-Mails',
      'es': 'Correos profesionales',
    },
    'Using a smartphone and apps': {
      'ro': 'Smartphone și aplicații',
      'fr': 'Smartphone et applis',
      'de': 'Smartphone und Apps',
      'es': 'Smartphone y aplicaciones',
    },
    'Browsing the internet': {
      'ro': 'Navigare pe internet',
      'fr': 'Naviguer sur Internet',
      'de': 'Im Internet surfen',
      'es': 'Navegar por internet',
    },
    
    // Additional Missing Nodes
    'Introductions and names': {
      'ro': 'Prezentări și nume',
      'fr': 'Présentations et noms',
      'de': 'Vorstellungen und Namen',
      'es': 'Presentaciones y nombres',
    },
    'Family members and relations': {
      'ro': 'Membrii familiei și relații',
      'fr': 'Membres de la famille',
      'de': 'Familienmitglieder',
      'es': 'Miembros de la familia',
    },
    'Describing your home': {
      'ro': 'Descrierea casei tale',
      'fr': 'Décrire sa maison',
      'de': 'Dein Zuhause beschreiben',
      'es': 'Describir tu hogar',
    },
    'Pets and common animals': {
      'ro': 'Animale de companie',
      'fr': 'Animaux de compagnie',
      'de': 'Haustiere und Tiere',
      'es': 'Mascotas y animales',
    },
    'At the local restaurant': {
      'ro': 'La restaurant',
      'fr': 'Au restaurant local',
      'de': 'Im Restaurant',
      'es': 'En el restaurante',
    },
    'Groceries and ingredients': {
      'ro': 'Alimente și ingrediente',
      'fr': 'Épicerie et ingrédients',
      'de': 'Lebensmittel und Zutaten',
      'es': 'Comestibles e ingredientes',
    },
    'Asking for directions': {
      'ro': 'Cererea de indicații',
      'fr': 'Demander son chemin',
      'de': 'Nach dem Weg fragen',
      'es': 'Pedir indicaciones',
    },
    'At the airport and hotel': {
      'ro': 'La aeroport și hotel',
      'fr': 'À l\'aéroport et à l\'hôtel',
      'de': 'Am Flughafen und Hotel',
      'es': 'En el aeropuerto y hotel',
    },
    'School and university terms': {
      'ro': 'Termeni școlari',
      'fr': 'Termes scolaires',
      'de': 'Schulbegriffe',
      'es': 'Términos escolares',
    },
    'Books, reading, and writing': {
      'ro': 'Cărți, lectură și scriere',
      'fr': 'Livres, lecture et écriture',
      'de': 'Bücher, Lesen und Schreiben',
      'es': 'Libros, lectura y escritura',
    },
    'Office conversation': {
      'ro': 'Conversație de birou',
      'fr': 'Conversation de bureau',
      'de': 'Bürogespräche',
      'es': 'Conversación de oficina',
    },
    'Job interviews and roles': {
      'ro': 'Interviuri și roluri',
      'fr': 'Entretiens d\'embauche',
      'de': 'Vorstellungsgespräche',
      'es': 'Entrevistas y roles',
    },
    'Purchasing items and prices': {
      'ro': 'Achiziții și prețuri',
      'fr': 'Achats et prix',
      'de': 'Artikel kaufen und Preise',
      'es': 'Compras y precios',
    },
    'Clothing and sizes': {
      'ro': 'Îmbrăcăminte și mărimi',
      'fr': 'Vêtements et tailles',
      'de': 'Kleidung und Größen',
      'es': 'Ropa y tallas',
    },
    'At the doctor clinic': {
      'ro': 'La medic',
      'fr': 'Chez le médecin',
      'de': 'Beim Arzt',
      'es': 'En el médico',
    },
    'Body parts and feelings': {
      'ro': 'Părți ale corpului și emoții',
      'fr': 'Parties du corps et émotions',
      'de': 'Körperteile und Gefühle',
      'es': 'Partes del cuerpo y emociones',
    },
    'Public transportation': {
      'ro': 'Transport public',
      'fr': 'Transports en commun',
      'de': 'Öffentliche Verkehrsmittel',
      'es': 'Transporte público',
    },
    'Core words': {
      'ro': 'Cuvinte de bază',
      'fr': 'Mots de base',
      'de': 'Grundwörter',
      'es': 'Palabras clave',
    },
    'Advanced fluency challenges': {
      'ro': 'Provocări avansate',
      'fr': 'Défis de fluidité avancés',
      'de': 'Herausforderungen für Fortgeschrittene',
      'es': 'Retos de fluidez avanzada',
    },
  };

  // 3. UNIT DESCRIPTIONS (The small text under the headers)
  static const Map<String, Map<String, String>> _unitDescriptions = {
    'Basics': {
      'en': 'Essential greetings, simple responses, colors, and dates.',
      'ro': 'Saluturi esențiale, răspunsuri simple, culori și date.',
      'fr': 'Salutations essentielles, réponses simples, couleurs et dates.',
      'de': 'Grundlegende Begrüßungen, einfache Antworten, Farben und Daten.',
      'es': 'Saludos esenciales, respuestas simples, colores y fechas.',
    },
    'Family & Home': {
      'en': 'Describe relatives, home life, pets, and relationships.',
      'ro': 'Descrie rudele, viața de familie, animalele de companie și relațiile.',
      'fr': 'Décrire les parents, la vie de famille, les animaux et les relations.',
      'de': 'Verwandte, Familienleben, Haustiere und Beziehungen beschreiben.',
      'es': 'Describe familiares, vida hogareña, mascotas y relaciones.',
    },
    'Food & Dining': {
      'en': 'Order meals, cafes, ingredients, and dining out.',
      'ro': 'Comenzi de mâncare, cafenele, ingrediente și ieșiri la restaurant.',
      'fr': 'Commander des repas, cafés, ingrédients et manger au restaurant.',
      'de': 'Mahlzeiten bestellen, Cafés, Zutaten und Essen gehen.',
      'es': 'Pide comidas, cafés, ingredientes y salir a cenar.',
    },
    'Travel & Transit': {
      'en': 'Directions, airport navigation, hotels, and transit.',
      'ro': 'Direcții, navigare în aeroport, hoteluri și transport.',
      'fr': 'Itinéraires, navigation à l\'aéroport, hôtels et transports.',
      'de': 'Wegbeschreibungen, Flughafennavigation, Hotels und Verkehr.',
      'es': 'Indicaciones, navegación en aeropuertos, hoteles y transporte.',
    },
    'Education & Study': {
      'en': 'Academic conversations, studying, and learning terms.',
      'ro': 'Conversații academice, studiu și termeni de învățare.',
      'fr': 'Conversations académiques, études et termes d\'apprentissage.',
      'de': 'Akademische Gespräche, Studium und Lernbegriffe.',
      'es': 'Conversaciones académicas, estudios y términos de aprendizaje.',
    },
    'Work & Career': {
      'en': 'Office communication, job roles, and career discussions.',
      'ro': 'Comunicare la birou, roluri și discuții despre carieră.',
      'fr': 'Communication au bureau, rôles professionnels et carrières.',
      'de': 'Bürokommunikation, Berufsrollen und Karrierediskussionen.',
      'es': 'Comunicación en la oficina, roles laborales y carrera.',
    },
    'Shopping & Market': {
      'en': 'Purchasing items, prices, markets, and store terms.',
      'ro': 'Achiziționarea de articole, prețuri, piețe și termeni de magazin.',
      'fr': 'Achats d\'articles, prix, marchés et termes de magasin.',
      'de': 'Einkauf von Artikeln, Preisen, Märkten und Geschäftsbedingungen.',
      'es': 'Compra de artículos, precios, mercados y tiendas.',
    },
    'Health & Wellbeing': {
      'en': 'Medical visits, body parts, and wellbeing.',
      'ro': 'Vizite medicale, părți ale corpului și bunăstare.',
      'fr': 'Visites médicales, parties du corps et bien-être.',
      'de': 'Arztbesuche, Körperteile und Wohlbefinden.',
      'es': 'Visitas médicas, partes del cuerpo y bienestar.',
    },
    'General Vocabulary - Final Challenge': {
      'en': 'Test your overall mastery across the comprehensive vocabulary library.',
      'ro': 'Testează-ți stăpânirea generală a întregului vocabular.',
      'fr': 'Testez votre maîtrise globale sur l\'ensemble du vocabulaire.',
      'de': 'Testen Sie Ihre Gesamtbeherrschung des gesamten Wortschatzes.',
      'es': 'Pon a prueba tu dominio de todo el vocabulario.',
    },
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

  /// Translates the small description under the Unit header
  static String translateDescription(String englishUnit, String langCode) {
    if (langCode == 'en') return _unitDescriptions[englishUnit]?['en'] ?? '';
    return _unitDescriptions[englishUnit]?[langCode] ?? _unitDescriptions[englishUnit]?['en'] ?? '';
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