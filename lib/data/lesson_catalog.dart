import '../models/course.dart';
import '../models/lesson_block.dart';
import '../models/srs_models.dart';

class LessonCatalog {
  static List<SentencePair> getSentencePairs({
    required String topic,
    String targetLanguage = 'Spanish',
  }) {
    final lang = targetLanguage.trim().toLowerCase();
    final langCode = lang.contains('french')
        ? 'fr'
        : lang.contains('german')
            ? 'de'
            : lang.contains('japanese')
                ? 'ja'
                : 'es';

    final t = topic.trim().toLowerCase();

    if (langCode == 'es') {
      if (t.contains('greetings') || t.contains('first')) {
        return [
          SentencePair(
            id: 'g_es_1',
            sourceText: 'Hello, how are you?',
            targetText: 'Hola, ¿cómo estás?',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“¿Cómo estás?” is informal, used with friends and peers.',
          ),
          SentencePair(
            id: 'g_es_2',
            sourceText: 'Good morning!',
            targetText: '¡Buenos días!',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Used until midday.',
          ),
          SentencePair(
            id: 'g_es_3',
            sourceText: 'Good evening!',
            targetText: '¡Buenas noches!',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Used after sunset.',
          ),
          SentencePair(
            id: 'g_es_4',
            sourceText: 'See you tomorrow!',
            targetText: '¡Hasta mañana!',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Hasta” means until.',
          ),
          SentencePair(
            id: 'g_es_5',
            sourceText: 'Goodbye, see you soon!',
            targetText: '¡Adiós, hasta pronto!',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Pronto” means soon.',
          ),
        ];
      } else if (t.contains('intro') || t.contains('name') || t.contains('yourself')) {
        return [
          SentencePair(
            id: 'intro_es_1',
            sourceText: 'My name is Carlos.',
            targetText: 'Me llamo Carlos.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Me llamo” literally translates to “I call myself”.',
          ),
          SentencePair(
            id: 'intro_es_2',
            sourceText: 'Nice to meet you.',
            targetText: 'Mucho gusto.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Standard polite introduction response.',
          ),
          SentencePair(
            id: 'intro_es_3',
            sourceText: 'Where are you from?',
            targetText: '¿De dónde eres?',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Informal form asking about origin.',
          ),
          SentencePair(
            id: 'intro_es_4',
            sourceText: 'I am from Spain.',
            targetText: 'Soy de España.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Use “ser” (soy) for origin and nationality.',
          ),
          SentencePair(
            id: 'intro_es_5',
            sourceText: 'How old are you?',
            targetText: '¿Cuántos años tienes?',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'In Spanish you “have” (tener) years.',
          ),
        ];
      } else if (t.contains('polite') || t.contains('expression')) {
        return [
          SentencePair(
            id: 'polite_es_1',
            sourceText: 'Thank you very much.',
            targetText: 'Muchas gracias.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Standard phrase expressing deep thanks.',
          ),
          SentencePair(
            id: 'polite_es_2',
            sourceText: 'You are welcome.',
            targetText: 'De nada.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Literally means “of nothing”.',
          ),
          SentencePair(
            id: 'polite_es_3',
            sourceText: 'Excuse me, please.',
            targetText: 'Disculpe, por favor.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Polite way to grab someone’s attention.',
          ),
          SentencePair(
            id: 'polite_es_4',
            sourceText: 'I am very sorry.',
            targetText: 'Lo siento mucho.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Expresses sincere apology.',
          ),
          SentencePair(
            id: 'polite_es_5',
            sourceText: 'No problem.',
            targetText: 'No hay problema.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“No hay” means “there is no”.',
          ),
        ];
      } else if (t.contains('coffee') || t.contains('order')) {
        return [
          SentencePair(
            id: 'cafe_es_1',
            sourceText: 'I would like a coffee, please.',
            targetText: 'Quisiera un café, por favor.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Quisiera” is polite conditional form of querer.',
          ),
          SentencePair(
            id: 'cafe_es_2',
            sourceText: 'With milk and sugar.',
            targetText: 'Con leche y azúcar.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Common coffee preference specifications.',
          ),
          SentencePair(
            id: 'cafe_es_3',
            sourceText: 'Can I have the check?',
            targetText: '¿Me trae la cuenta?',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Polite request for the check.',
          ),
          SentencePair(
            id: 'cafe_es_4',
            sourceText: 'A cold water, please.',
            targetText: 'Un agua fría, por favor.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Agua” is feminine noun using masculine article “un”.',
          ),
        ];
      } else if (t.contains('restaurant') || t.contains('food')) {
        return [
          SentencePair(
            id: 'rest_es_1',
            sourceText: 'A table for two, please.',
            targetText: 'Una mesa para dos, por favor.',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Standard restaurant greeting upon entering.',
          ),
          SentencePair(
            id: 'rest_es_2',
            sourceText: 'What do you recommend?',
            targetText: '¿Qué me recomienda?',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Asking the waiter for popular dishes.',
          ),
          SentencePair(
            id: 'rest_es_3',
            sourceText: 'The food is delicious!',
            targetText: '¡La comida está deliciosa!',
            languageCode: 'es',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Use “estar” for taste state of food.',
          ),
        ];
      } else if (t.contains('tech') || t.contains('interview')) {
        return [
          SentencePair(
            id: 'tech_es_1',
            sourceText: 'I have 5 years experience in coding.',
            targetText: 'Tengo 5 años de experiencia en programación.',
            languageCode: 'es',
            difficultyLevel: 'B1',
            topicCategory: topic,
            grammarNotes: '“Tengo” is first-person present of tener.',
          ),
          SentencePair(
            id: 'tech_es_2',
            sourceText: 'We build modern mobile applications.',
            targetText: 'Desarrollamos aplicaciones móviles modernas.',
            languageCode: 'es',
            difficultyLevel: 'B1',
            topicCategory: topic,
            grammarNotes: '“Desarrollamos” means we develop/build.',
          ),
          SentencePair(
            id: 'tech_es_3',
            sourceText: 'My main skill is Flutter development.',
            targetText: 'Mi habilidad principal es el desarrollo en Flutter.',
            languageCode: 'es',
            difficultyLevel: 'B1',
            topicCategory: topic,
            grammarNotes: 'Describing technical proficiency.',
          ),
        ];
      }
    } else if (langCode == 'fr') {
      if (t.contains('greetings') || t.contains('first')) {
        return [
          SentencePair(
            id: 'g_fr_1',
            sourceText: 'Hello, how are you?',
            targetText: 'Bonjour, comment allez-vous ?',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Comment allez-vous ?” is formal.',
          ),
          SentencePair(
            id: 'g_fr_2',
            sourceText: 'Good evening!',
            targetText: 'Bonsoir !',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Used in late afternoon and evening.',
          ),
          SentencePair(
            id: 'g_fr_3',
            sourceText: 'See you tomorrow!',
            targetText: 'À demain !',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Demain” means tomorrow.',
          ),
        ];
      } else if (t.contains('intro') || t.contains('name') || t.contains('yourself')) {
        return [
          SentencePair(
            id: 'intro_fr_1',
            sourceText: 'My name is Jean.',
            targetText: 'Je m\'appelle Jean.',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: '“Je m\'appelle” means I call myself.',
          ),
          SentencePair(
            id: 'intro_fr_2',
            sourceText: 'Pleased to meet you.',
            targetText: 'Enchanté de vous rencontrer.',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Standard polite French introduction.',
          ),
        ];
      } else if (t.contains('polite') || t.contains('expression')) {
        return [
          SentencePair(
            id: 'polite_fr_1',
            sourceText: 'Thank you very much.',
            targetText: 'Merci beaucoup.',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Standard expression of thanks.',
          ),
          SentencePair(
            id: 'polite_fr_2',
            sourceText: 'You are welcome.',
            targetText: 'De rien.',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Literally means of nothing.',
          ),
          SentencePair(
            id: 'polite_fr_3',
            sourceText: 'Please.',
            targetText: 'S\'il vous plaît.',
            languageCode: 'fr',
            difficultyLevel: 'A1',
            topicCategory: topic,
            grammarNotes: 'Formal request phrasing.',
          ),
        ];
      }
    }

    // Default fallback deck for topic
    return [
      SentencePair(
        id: '${topic}_def_1',
        sourceText: 'Welcome to $topic!',
        targetText: 'Bienvenido a $topic!',
        languageCode: langCode,
        difficultyLevel: 'A1',
        topicCategory: topic,
        grammarNotes: 'General introduction expression.',
      ),
      SentencePair(
        id: '${topic}_def_2',
        sourceText: 'Thank you for practicing.',
        targetText: 'Gracias por practicar.',
        languageCode: langCode,
        difficultyLevel: 'A1',
        topicCategory: topic,
        grammarNotes: 'Polite closing statement.',
      ),
    ];
  }

  static List<CourseUnit> getCourseUnits({
    required String targetLanguage,
    Set<String> completedTopics = const {},
  }) {
    final List<CourseUnit> baseUnits = [
      CourseUnit(
        id: 'unit_1',
        unitNumber: 1,
        title: 'Foundations & Greetings',
        description: 'Master basic introductions, hellos, and polite phrases.',
        levelBadge: 'A1 Beginner',
        lessons: [
          LessonNode(
            id: 'u1_l1',
            title: 'First Greetings',
            description: 'Hello, Goodbye & Essential Politeness',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 25,
            topic: 'First Greetings',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u1_l2',
            title: 'Introducing Yourself',
            description: 'Names, origins & basic facts',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 25,
            topic: 'Introducing Yourself',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u1_l3',
            title: 'Polite Expressions',
            description: 'Thank you, Excuse me & Sorry',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 25,
            topic: 'Polite Expressions',
            targetLanguage: targetLanguage,
          ),
        ],
      ),
      CourseUnit(
        id: 'unit_2',
        unitNumber: 2,
        title: 'Food & Ordering',
        description: 'Order food, drinks, and handle café checks.',
        levelBadge: 'A1 Beginner',
        lessons: [
          LessonNode(
            id: 'u2_l1',
            title: 'Ordering Coffee',
            description: 'Café drinks, sugar & milk options',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 30,
            topic: 'Ordering Coffee',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u2_l2',
            title: 'At the Restaurant',
            description: 'Menus, tables & reservations',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 30,
            topic: 'At the Restaurant',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u2_l3',
            title: 'Paying the Check',
            description: 'Bills, tips & receipts',
            level: 'A1',
            status: LessonNodeStatus.locked,
            xpReward: 30,
            topic: 'Paying the Check',
            targetLanguage: targetLanguage,
          ),
        ],
      ),
      CourseUnit(
        id: 'unit_3',
        unitNumber: 3,
        title: 'Travel & Navigation',
        description: 'Ask for directions, hotels & train tickets.',
        levelBadge: 'A2 Elementary',
        lessons: [
          LessonNode(
            id: 'u3_l1',
            title: 'Finding Directions',
            description: 'Left, right, straight & landmarks',
            level: 'A2',
            status: LessonNodeStatus.locked,
            xpReward: 35,
            topic: 'Finding Directions',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u3_l2',
            title: 'At the Airport',
            description: 'Passports, boarding & luggage',
            level: 'A2',
            status: LessonNodeStatus.locked,
            xpReward: 35,
            topic: 'At the Airport',
            targetLanguage: targetLanguage,
          ),
        ],
      ),
      CourseUnit(
        id: 'unit_4',
        unitNumber: 4,
        title: 'Tech & Job Interviews',
        description: 'Prepare for software interviews and technical Q&A.',
        levelBadge: 'B1 Intermediate',
        lessons: [
          LessonNode(
            id: 'u4_l1',
            title: 'Tech interview terms',
            description: 'Experience, resumes & key skills',
            level: 'B1',
            status: LessonNodeStatus.locked,
            xpReward: 40,
            topic: 'Tech interview terms',
            targetLanguage: targetLanguage,
          ),
          LessonNode(
            id: 'u4_l2',
            title: 'Action Verbs in Coding',
            description: 'Develop, optimize & manage',
            level: 'B1',
            status: LessonNodeStatus.locked,
            xpReward: 40,
            topic: 'Action Verbs in Coding',
            targetLanguage: targetLanguage,
          ),
        ],
      ),
    ];

    bool unlockedNextActive = false;
    final List<CourseUnit> dynamicUnits = [];

    for (var unit in baseUnits) {
      final List<LessonNode> dynamicLessons = [];
      for (var lesson in unit.lessons) {
        final isDone = completedTopics.contains(lesson.topic);
        if (isDone) {
          dynamicLessons.add(lesson.copyWith(
            status: LessonNodeStatus.completed,
            stars: 3,
          ));
        } else if (!unlockedNextActive) {
          unlockedNextActive = true;
          dynamicLessons.add(lesson.copyWith(
            status: LessonNodeStatus.active,
          ));
        } else {
          dynamicLessons.add(lesson.copyWith(
            status: LessonNodeStatus.locked,
          ));
        }
      }
      dynamicUnits.add(unit.copyWith(lessons: dynamicLessons));
    }

    return dynamicUnits;
  }


  static List<LessonBlock> getLesson({
    required String topic,
    required String targetLanguage,
  }) {
    final t = topic.trim().toLowerCase();
    final lang = targetLanguage.trim().toLowerCase();

    if (t.contains('greetings') || t.contains('first')) {
      return _getGreetingsChallenge(topic, lang);
    } else if (t.contains('intro') || t.contains('name')) {
      return _getIntroducingChallenge(topic, lang);
    } else if (t.contains('polite') || t.contains('expression')) {
      return _getPoliteChallenge(topic, lang);
    } else if (t.contains('coffee') || t.contains('order')) {
      return _getCoffeeChallenge(topic, lang);
    } else if (t.contains('tech') || t.contains('interview')) {
      return _getTechInterviewChallenge(topic, lang);
    } else {
      return _getGeneralChallenge(topic, lang);
    }
  }

  static List<LessonBlock> _getGreetingsChallenge(String topic, String lang) {
    if (lang.contains('french')) {
      return [
        LessonBlock(
          id: 'g_fr_1',
          lessonId: topic,
          orderIndex: 1,
          type: 'explanation',
          title: 'salutations fondamentales',
          content: 'Voici les expressions essentielles pour saluer en français :\n\n• Bonjour = Hello (Formal / Day)\n• Salut = Hi (Informal)\n• Bonsoir = Good evening\n• Au revoir = Goodbye\n• À bientôt = See you soon',
        ),
        LessonBlock(
          id: 'g_fr_2',
          lessonId: topic,
          orderIndex: 2,
          type: 'matching',
          title: 'Test de correspondance 1',
          content: 'Associez chaque salutation à sa signification :',
          matchingPairs: {
            'Bonjour': 'Hello',
            'Salut': 'Hi',
            'Au revoir': 'Goodbye',
            'À bientôt': 'See you soon',
          },
        ),
        LessonBlock(
          id: 'g_fr_3',
          lessonId: topic,
          orderIndex: 3,
          type: 'multiple_choice',
          title: 'Choix multiple 1',
          content: 'Quelle salutation utilisez-vous le matin avec votre professeur ?',
          options: ['Bonjour', 'Salut', 'Bonne nuit', 'À plus tard'],
          correctAnswer: 'Bonjour',
          explanation: '"Bonjour" is the respectful and standard greeting during the day.',
        ),
        LessonBlock(
          id: 'g_fr_4',
          lessonId: topic,
          orderIndex: 4,
          type: 'sentence_builder',
          title: 'Construction de phrase 1',
          content: 'Formez la phrase : "Hello, how are you?"',
          wordBank: ['Bonjour,', 'comment', 'allez-vous', '?', 'merci', 'au revoir'],
          correctAnswer: 'Bonjour, comment allez-vous ?',
          explanation: '"Bonjour, comment allez-vous ?" is formal and polite.',
        ),
        LessonBlock(
          id: 'g_fr_5',
          lessonId: topic,
          orderIndex: 5,
          type: 'matching',
          title: 'Test de correspondance 2',
          content: 'Associez les formules de politesse :',
          matchingPairs: {
            'S\'il vous plaît': 'Please',
            'Merci beaucoup': 'Thank you very much',
            'De rien': 'You are welcome',
            'Excusez-moi': 'Excuse me',
          },
        ),
        LessonBlock(
          id: 'g_fr_6',
          lessonId: topic,
          orderIndex: 6,
          type: 'multiple_choice',
          title: 'Choix multiple 2',
          content: 'Que répondez-vous quand quelqu\'un vous dit "Merci" ?',
          options: ['De rien', 'Au revoir', 'S\'il vous plaît', 'Bonjour'],
          correctAnswer: 'De rien',
          explanation: '"De rien" means "You\'re welcome" in French.',
        ),
        LessonBlock(
          id: 'g_fr_7',
          lessonId: topic,
          orderIndex: 7,
          type: 'sentence_builder',
          title: 'Construction de phrase 2',
          content: 'Formez la phrase : "Good evening, see you tomorrow!"',
          wordBank: ['Bonsoir,', 'à', 'demain', '!', 'salut', 'merci'],
          correctAnswer: 'Bonsoir, à demain !',
          explanation: '"Bonsoir, à demain !" translates to "Good evening, see you tomorrow!"',
        ),
        LessonBlock(
          id: 'g_fr_8',
          lessonId: topic,
          orderIndex: 8,
          type: 'multiple_choice',
          title: 'Évaluation Finale',
          content: 'Comment dites-vous "Goodbye and thank you" ?',
          options: [
            'Au revoir et merci',
            'Bonjour et s\'il vous plaît',
            'À bientôt et de rien',
            'Bonsoir et pardon'
          ],
          correctAnswer: 'Au revoir et merci',
          explanation: '"Au revoir et merci" combines goodbye and thanks.',
        ),
      ];
    } else if (lang.contains('german')) {
      return [
        LessonBlock(
          id: 'g_de_1',
          lessonId: topic,
          orderIndex: 1,
          type: 'explanation',
          title: 'Deutsche Begrüßungen',
          content: 'Lernen Sie die wichtigsten Ausdrücke:\n\n• Hallo = Hello\n• Guten Morgen = Good morning\n• Guten Tag = Good day\n• Auf Wiedersehen = Goodbye\n• Danke schön = Thank you very much',
        ),
        LessonBlock(
          id: 'g_de_2',
          lessonId: topic,
          orderIndex: 2,
          type: 'matching',
          title: 'Wortpaar-Test 1',
          content: 'Verbinden Sie die Begriffe:',
          matchingPairs: {
            'Hallo': 'Hello',
            'Guten Morgen': 'Good morning',
            'Auf Wiedersehen': 'Goodbye',
            'Danke schön': 'Thank you very much',
          },
        ),
        LessonBlock(
          id: 'g_de_3',
          lessonId: topic,
          orderIndex: 3,
          type: 'multiple_choice',
          title: 'Mehrfachauswahl 1',
          content: 'Was sagen Sie morgens um 8:00 Uhr?',
          options: ['Guten Morgen', 'Guten Abend', 'Gute Nacht', 'Tschüss'],
          correctAnswer: 'Guten Morgen',
          explanation: '"Guten Morgen" is used in the morning until around noon.',
        ),
        LessonBlock(
          id: 'g_de_4',
          lessonId: topic,
          orderIndex: 4,
          type: 'sentence_builder',
          title: 'Satzbau 1',
          content: 'Bauen Sie den Satz: "Hello, how are you?"',
          wordBank: ['Hallo,', 'wie', 'geht', 'es', 'Ihnen', '?', 'Danke'],
          correctAnswer: 'Hallo, wie geht es Ihnen ?',
          explanation: '"Hallo, wie geht es Ihnen?" is standard polite German.',
        ),
        LessonBlock(
          id: 'g_de_5',
          lessonId: topic,
          orderIndex: 5,
          type: 'matching',
          title: 'Wortpaar-Test 2',
          content: 'Verbinden Sie die Höflichkeitsformen:',
          matchingPairs: {
            'Bitte': 'Please',
            'Entschuldigung': 'Excuse me',
            'Gern geschehen': 'You are welcome',
            'Tschüss': 'Bye',
          },
        ),
        LessonBlock(
          id: 'g_de_6',
          lessonId: topic,
          orderIndex: 6,
          type: 'sentence_builder',
          title: 'Satzbau 2',
          content: 'Bauen Sie den Satz: "Goodbye and see you tomorrow!"',
          wordBank: ['Auf', 'Wiedersehen', 'und', 'bis', 'morgen', '!'],
          correctAnswer: 'Auf Wiedersehen und bis morgen !',
          explanation: '"Auf Wiedersehen und bis morgen!" is a complete polite departure.',
        ),
      ];
    } else {
      return [
        LessonBlock(
          id: 'g_es_1',
          lessonId: topic,
          orderIndex: 1,
          type: 'explanation',
          title: 'Saludos esenciales',
          content: 'Frases esenciales en español:\n\n• Hola = Hello\n• Buenos días = Good morning\n• Buenas tardes = Good afternoon\n• Hasta luego = See you later\n• Muchas gracias = Thank you very much',
        ),
        LessonBlock(
          id: 'g_es_2',
          lessonId: topic,
          orderIndex: 2,
          type: 'matching',
          title: 'Emparejamiento 1',
          content: 'Une cada saludo con su significado:',
          matchingPairs: {
            'Hola': 'Hello',
            'Buenos días': 'Good morning',
            'Hasta luego': 'See you later',
            'Muchas gracias': 'Thank you very much',
          },
        ),
        LessonBlock(
          id: 'g_es_3',
          lessonId: topic,
          orderIndex: 3,
          type: 'multiple_choice',
          title: 'Opción múltiple 1',
          content: '¿Qué dices por la mañana al llegar?',
          options: ['Buenos días', 'Buenas noches', 'Hasta mañana', 'De nada'],
          correctAnswer: 'Buenos días',
          explanation: '"Buenos días" is the proper morning greeting.',
        ),
        LessonBlock(
          id: 'g_es_4',
          lessonId: topic,
          orderIndex: 4,
          type: 'sentence_builder',
          title: 'Constructor de frases 1',
          content: 'Forma la frase: "Hello, how are you?"',
          wordBank: ['Hola,', '¿cómo', 'estás', '?', 'gracias', 'adiós'],
          correctAnswer: 'Hola, ¿cómo estás ?',
          explanation: '"Hola, ¿cómo estás?" is friendly and universal.',
        ),
        LessonBlock(
          id: 'g_es_5',
          lessonId: topic,
          orderIndex: 5,
          type: 'matching',
          title: 'Emparejamiento 2',
          content: 'Une las expresiones de cortesía:',
          matchingPairs: {
            'Por favor': 'Please',
            'De nada': 'You are welcome',
            'Disculpe': 'Excuse me',
            'Hasta mañana': 'See you tomorrow',
          },
        ),
        LessonBlock(
          id: 'g_es_6',
          lessonId: topic,
          orderIndex: 6,
          type: 'sentence_builder',
          title: 'Constructor de frases 2',
          content: 'Forma la frase: "Goodbye and see you tomorrow!"',
          wordBank: ['Adiós', 'y', 'hasta', 'mañana', '!'],
          correctAnswer: 'Adiós y hasta mañana !',
          explanation: '"Adiós y hasta mañana!" is clear and conversational.',
        ),
      ];
    }
  }

  static List<LessonBlock> _getIntroducingChallenge(String topic, String lang) {
    return [
      LessonBlock(
        id: 'intro_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Personal Introductions',
        content: 'Learn to talk about yourself in $lang:\n\n• My name is... = Je m\'appelle... / Me llamo... / Ich heiße...\n• I live in... = J\'habite à... / Vivo en... / Ich wohne in...\n• Nice to meet you = Enchanté / Mucho gusto / Schön Sie kennenzulernen',
      ),
      LessonBlock(
        id: 'intro_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'matching',
        title: 'Matching Pairs',
        content: 'Match the self-introduction phrases:',
        matchingPairs: {
          'My name is': 'Je m\'appelle / Me llamo',
          'I live in': 'J\'habite à / Vivo en',
          'Nice to meet you': 'Enchanté / Mucho gusto',
          'I am from': 'Je viens de / Soy de',
        },
      ),
      LessonBlock(
        id: 'intro_3',
        lessonId: topic,
        orderIndex: 3,
        type: 'sentence_builder',
        title: 'Sentence Construction',
        content: 'Build the sentence: "My name is John and I live in Paris."',
        wordBank: ['Je', 'm\'appelle', 'John', 'et', 'j\'habite', 'à', 'Paris', '.'],
        correctAnswer: 'Je m\'appelle John et j\'habite à Paris .',
        explanation: 'Combine name + location smoothly in one sentence.',
      ),
    ];
  }

  static List<LessonBlock> _getPoliteChallenge(String topic, String lang) {
    return [
      LessonBlock(
        id: 'pol_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Polite Expressions',
        content: 'Master courtesy in $lang:\n\n• Thank you = Merci / Gracias / Danke\n• You\'re welcome = De rien / De nada / Bitte\n• Excuse me = Excusez-moi / Perdone / Entschuldigung',
      ),
      LessonBlock(
        id: 'pol_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'matching',
        title: 'Courtesy Pairs',
        content: 'Match courtesy expressions:',
        matchingPairs: {
          'Thank you': 'Merci / Gracias',
          'You\'re welcome': 'De rien / De nada',
          'Excuse me': 'Excusez-moi / Perdone',
          'Sorry': 'Pardon / Lo siento',
        },
      ),
    ];
  }

  static List<LessonBlock> _getCoffeeChallenge(String topic, String lang) {
    return [
      LessonBlock(
        id: 'c_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Café Vocabulary',
        content: 'Ordering coffee terms:\n\n• Coffee with milk = Un café au lait / Un café con leche / Kaffee mit Milch\n• Sugar = Du sucre / Azúcar / Zucker\n• The check = L\'addition / La cuenta / Die Rechnung',
      ),
      LessonBlock(
        id: 'c_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'matching',
        title: 'Café Matching',
        content: 'Match café terms:',
        matchingPairs: {
          'Coffee with milk': 'Un café au lait',
          'Sugar': 'Du sucre',
          'The check': 'L\'addition',
          'Please': 'S\'il vous plaît',
        },
      ),
      LessonBlock(
        id: 'c_3',
        lessonId: topic,
        orderIndex: 3,
        type: 'sentence_builder',
        title: 'Ordering Sentence',
        content: 'Construct: "A coffee with milk and sugar, please."',
        wordBank: ['Un', 'café', 'au', 'lait', 'et', 'du', 'sucre', ',', 's\'il', 'vous', 'plaît'],
        correctAnswer: 'Un café au lait et du sucre , s\'il vous plaît',
        explanation: 'Politely state your full coffee preference.',
      ),
    ];
  }

  static List<LessonBlock> _getTechInterviewChallenge(String topic, String lang) {
    return [
      LessonBlock(
        id: 't_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Tech Interview Vocab',
        content: 'Technical career terms:\n\n• Job Interview = Entretien d\'embauche / Vorstellungsgespräch\n• Resume = CV / Lebenslauf\n• Experience = Expérience / Erfahrung\n• Skills = Compétences / Fähigkeiten',
      ),
      LessonBlock(
        id: 't_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'matching',
        title: 'Career Matching',
        content: 'Match key career terms:',
        matchingPairs: {
          'Job Interview': 'Entretien d\'embauche',
          'Resume': 'Curriculum Vitae',
          'Skills': 'Compétences',
          'Salary': 'Rémunération',
        },
      ),
      LessonBlock(
        id: 't_3',
        lessonId: topic,
        orderIndex: 3,
        type: 'sentence_builder',
        title: 'Interview Sentence',
        content: 'Construct: "I have 5 years experience in software development."',
        wordBank: ['J\'ai', '5 ans', 'd\'expérience', 'en', 'développement', 'logiciel', '.'],
        correctAnswer: 'J\'ai 5 ans d\'expérience en développement logiciel .',
        explanation: 'Expressing your professional background clearly.',
      ),
    ];
  }

  static List<LessonBlock> _getGeneralChallenge(String topic, String lang) {
    return [
      LessonBlock(
        id: 'gen_1',
        lessonId: topic,
        orderIndex: 1,
        type: 'explanation',
        title: 'Challenge: $topic',
        content: 'Essential vocabulary and phrases for "$topic" in $lang.',
      ),
      LessonBlock(
        id: 'gen_2',
        lessonId: topic,
        orderIndex: 2,
        type: 'multiple_choice',
        title: 'Practice Question',
        content: 'Select the polite phrase:',
        options: ['Hello, nice to meet you!', 'Goodbye!', 'See you tomorrow.'],
        correctAnswer: 'Hello, nice to meet you!',
        explanation: 'Greeting politely sets a good tone for conversation.',
      ),
    ];
  }
}
