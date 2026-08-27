import '../models/guidebook.dart';

class GuidebookService {
  static GuidebookContent getGuidebook({
    required int unitNumber,
    required String targetLanguage,
    required String nativeLanguage,
  }) {
    final target = targetLanguage.trim().toLowerCase();

    if (target.contains('spanish') || target == 'es') {
      return _getSpanishGuidebook(unitNumber);
    } else if (target.contains('french') || target == 'fr') {
      return _getFrenchGuidebook(unitNumber);
    } else if (target.contains('german') || target == 'de') {
      return _getGermanGuidebook(unitNumber);
    } else if (target.contains('romanian') || target == 'ro') {
      return _getRomanianGuidebook(unitNumber);
    } else if (target.contains('italian') || target == 'it') {
      return _getItalianGuidebook(unitNumber);
    }

    return _getGenericGuidebook(unitNumber, targetLanguage);
  }

  static GuidebookContent _getSpanishGuidebook(int unitNumber) {
    switch (unitNumber) {
      case 1:
        return const GuidebookContent(
          unitNumber: 1,
          title: 'Foundations & Greetings',
          subtitle: 'Saying hello, introducing yourself, and informal vs formal speech',
          levelBadge: 'A1',
          sections: [
            GuidebookSection(
              sectionTitle: 'Key Phrases',
              explanation: 'Essential everyday greetings and introductions in Spanish.',
              keyPhrases: [
                KeyPhraseItem(
                  targetText: '¡Hola! ¿Cómo estás?',
                  translationText: 'Hello! How are you?',
                  phoneticOrNote: 'Informal, use with friends and peers',
                ),
                KeyPhraseItem(
                  targetText: 'Buenos días, mucho gusto.',
                  translationText: 'Good morning, nice to meet you.',
                  phoneticOrNote: 'Polite greeting',
                ),
                KeyPhraseItem(
                  targetText: 'Me llamo Carlos.',
                  translationText: 'My name is Carlos (I call myself).',
                  phoneticOrNote: 'Verb llamarse',
                ),
              ],
            ),
            GuidebookSection(
              sectionTitle: 'Tú vs. Usted (Informal vs. Formal)',
              explanation:
                  'In Spanish, there are two ways to say "you". Use "tú" for friends, family, and children. Use "usted" for elders, professionals, or showing respect.',
              grammarTip: 'Notice the difference: "¿Cómo estás tú?" (informal) vs "¿Cómo está usted?" (formal).',
            ),
            GuidebookSection(
              sectionTitle: 'The Verb "Ser" (To Be)',
              explanation: 'Used for permanent characteristics, origin, and identity.',
              table: GrammarTable(
                headers: ['Pronoun', 'Ser (Present)', 'English'],
                rows: [
                  ['Yo', 'soy', 'I am'],
                  ['Tú', 'eres', 'You are (informal)'],
                  ['Él / Ella / Usted', 'es', 'He / She is / You are (formal)'],
                  ['Nosotros', 'somos', 'We are'],
                  ['Ellos / Ellas / Uds.', 'son', 'They / You all are'],
                ],
              ),
              grammarTip: 'Spanish often drops subject pronouns because the verb ending reveals the subject: "Soy de Madrid" = "I am from Madrid".',
            ),
          ],
        );

      case 2:
        return const GuidebookContent(
          unitNumber: 2,
          title: 'Daily Life & Regular Verbs',
          subtitle: 'Everyday activities, present tense -ar, -er, -ir verbs',
          levelBadge: 'A1',
          sections: [
            GuidebookSection(
              sectionTitle: 'Present Tense Regular Verbs',
              explanation: 'Spanish verbs are divided into 3 conjugation families: -ar, -er, and -ir.',
              table: GrammarTable(
                headers: ['Pronoun', '-AR (Hablar)', '-ER (Comer)', '-IR (Vivir)'],
                rows: [
                  ['Yo', 'hablo', 'como', 'vivo'],
                  ['Tú', 'hablas', 'comes', 'vives'],
                  ['Él / Ella', 'habla', 'come', 'vive'],
                  ['Nosotros', 'hablamos', 'comemos', 'vivimos'],
                  ['Ellos / Ellas', 'hablan', 'comen', 'viven'],
                ],
              ),
              grammarTip: 'Remove the infinitive ending (-ar/-er/-ir) and add the matching subject suffix.',
            ),
            GuidebookSection(
              sectionTitle: 'Gender of Nouns (El vs La)',
              explanation:
                  'Nouns ending in -o are typically masculine ("el libro"), while nouns ending in -a are typically feminine ("la mesa").',
              grammarTip: 'Exceptions: "el problema", "el día", "la mano", "la foto".',
            ),
          ],
        );

      case 3:
        return const GuidebookContent(
          unitNumber: 3,
          title: 'Questions, Places & Directions',
          subtitle: 'Asking for directions, question words, and the verb Estar',
          levelBadge: 'A1-A2',
          sections: [
            GuidebookSection(
              sectionTitle: 'Question Words (Palabras Interrogativas)',
              explanation: 'All Spanish question words carry an accent mark in questions.',
              keyPhrases: [
                KeyPhraseItem(targetText: '¿Dónde está el baño?', translationText: 'Where is the bathroom?'),
                KeyPhraseItem(targetText: '¿Cuánto cuesta esto?', translationText: 'How much does this cost?'),
                KeyPhraseItem(targetText: '¿A qué hora abre?', translationText: 'What time does it open?'),
              ],
            ),
            GuidebookSection(
              sectionTitle: 'Ser vs. Estar (Both mean "To Be")',
              explanation:
                  'Use SER for permanent traits (DOCTOR: Description, Occupation, Characteristic, Time, Origin, Relation).\nUse ESTAR for temporary states & locations (PLACE: Position, Location, Action, Condition, Emotion).',
              grammarTip: '"La sopa está fría" (The soup is cold right now) vs "El hielo es frío" (Ice is naturally cold).',
            ),
          ],
        );

      default:
        return _getGenericGuidebook(unitNumber, 'Spanish');
    }
  }

  static GuidebookContent _getFrenchGuidebook(int unitNumber) {
    switch (unitNumber) {
      case 1:
        return const GuidebookContent(
          unitNumber: 1,
          title: 'Foundations & French Politeness',
          subtitle: 'Greetings, introductions, and Tu vs Vous',
          levelBadge: 'A1',
          sections: [
            GuidebookSection(
              sectionTitle: 'Key Phrases',
              explanation: 'Essential social phrases in French.',
              keyPhrases: [
                KeyPhraseItem(
                  targetText: 'Bonjour, comment allez-vous ?',
                  translationText: 'Hello, how are you doing? (formal)',
                ),
                KeyPhraseItem(
                  targetText: 'Salut ! Comment ça va ?',
                  translationText: 'Hi! How\'s it going? (informal)',
                ),
                KeyPhraseItem(
                  targetText: 'Je m\'appelle Sophie, enchanté.',
                  translationText: 'My name is Sophie, delighted to meet you.',
                ),
              ],
            ),
            GuidebookSection(
              sectionTitle: 'The Verb "Être" (To Be)',
              explanation: 'One of the two primary auxiliary verbs in French.',
              table: GrammarTable(
                headers: ['Pronoun', 'Être (Present)', 'English'],
                rows: [
                  ['Je', 'suis', 'I am'],
                  ['Tu', 'es', 'You are (informal)'],
                  ['Il / Elle / On', 'est', 'He / She / One is'],
                  ['Nous', 'sommes', 'We are'],
                  ['Vous', 'êtes', 'You are (formal/plural)'],
                  ['Ils / Elles', 'sont', 'They are'],
                ],
              ),
              grammarTip: 'Watch out for liaisons: "Vous êtes" is pronounced /voo-zett/.',
            ),
          ],
        );

      default:
        return _getGenericGuidebook(unitNumber, 'French');
    }
  }

  static GuidebookContent _getGermanGuidebook(int unitNumber) {
    switch (unitNumber) {
      case 1:
        return const GuidebookContent(
          unitNumber: 1,
          title: 'German Basics & Greetings',
          subtitle: 'Basic greetings, articles, and Du vs Sie',
          levelBadge: 'A1',
          sections: [
            GuidebookSection(
              sectionTitle: 'Key Phrases',
              explanation: 'Core everyday German expressions.',
              keyPhrases: [
                KeyPhraseItem(
                  targetText: 'Guten Tag, wie geht es Ihnen?',
                  translationText: 'Good day, how are you? (formal)',
                ),
                KeyPhraseItem(
                  targetText: 'Hallo! Wie geht es dir?',
                  translationText: 'Hello! How are you? (informal)',
                ),
                KeyPhraseItem(
                  targetText: 'Ich heiße Lukas. Freut mich.',
                  translationText: 'I am called Lukas. Pleased to meet you.',
                ),
              ],
            ),
            GuidebookSection(
              sectionTitle: 'The Three Genders: Der, Die, Das',
              explanation:
                  'German nouns have three grammatical genders: Masculine (der), Feminine (die), and Neuter (das). Always memorize nouns with their article and capitalize all nouns.',
              table: GrammarTable(
                headers: ['Gender', 'Definite Article', 'Example'],
                rows: [
                  ['Masculine', 'der', 'der Mann (the man), der Kaffee'],
                  ['Feminine', 'die', 'die Frau (the woman), die Straße'],
                  ['Neuter', 'das', 'das Kind (the child), das Buch'],
                ],
              ),
              grammarTip: 'ALL nouns in German must be capitalized, regardless of where they appear in a sentence.',
            ),
            GuidebookSection(
              sectionTitle: 'The Verb "Sein" (To Be)',
              explanation: 'Present tense conjugation of sein.',
              table: GrammarTable(
                headers: ['Pronoun', 'Sein (Present)', 'English'],
                rows: [
                  ['Ich', 'bin', 'I am'],
                  ['Du', 'bist', 'You are (informal)'],
                  ['Er / Sie / Es', 'ist', 'He / She / It is'],
                  ['Wir', 'sind', 'We are'],
                  ['Ihr', 'seid', 'You all are'],
                  ['Sie / sie', 'sind', 'You (formal) / They are'],
                ],
              ),
            ),
          ],
        );

      default:
        return _getGenericGuidebook(unitNumber, 'German');
    }
  }

  static GuidebookContent _getRomanianGuidebook(int unitNumber) {
    return GuidebookContent(
      unitNumber: unitNumber,
      title: unitNumber == 1 ? 'Foundations & Polite Forms' : 'Unit $unitNumber Grammar Guide',
      subtitle: 'Greetings, verb "a fi" (to be), and noun genders',
      levelBadge: 'A1',
      sections: [
        const GuidebookSection(
          sectionTitle: 'Key Phrases',
          explanation: 'Essential Romanian expressions.',
          keyPhrases: [
            KeyPhraseItem(
              targetText: 'Bună ziua, ce mai faceți?',
              translationText: 'Good day, how are you doing? (polite)',
            ),
            KeyPhraseItem(
              targetText: 'Mulțumesc mult, o zi frumoasă!',
              translationText: 'Thank you very much, have a nice day!',
            ),
            KeyPhraseItem(
              targetText: 'Mă numesc Andrei, încântat de cunoștință.',
              translationText: 'My name is Andrei, nice to meet you.',
            ),
          ],
        ),
        const GuidebookSection(
          sectionTitle: 'The Verb "A Fi" (To Be)',
          explanation: 'Present tense conjugation of a fi.',
          table: GrammarTable(
            headers: ['Pronume', 'A Fi (Prezent)', 'Engleză'],
            rows: [
              ['Eu', 'sunt', 'I am'],
              ['Tu', 'ești', 'You are (informal)'],
              ['El / Ea', 'este / e', 'He / She is'],
              ['Noi', 'suntem', 'We are'],
              ['Voi / Dumneavoastră', 'sunteți', 'You all / You (polite) are'],
              ['Ei / Ele', 'sunt', 'They are'],
            ],
          ),
          grammarTip: 'In spoken Romanian, "este" is often shortened to simply "e" (e.g. "Unde e gara?").',
        ),
      ],
    );
  }

  static GuidebookContent _getItalianGuidebook(int unitNumber) {
    return GuidebookContent(
      unitNumber: unitNumber,
      title: unitNumber == 1 ? 'Italian Basics & Pronunciation' : 'Unit $unitNumber Grammar Guide',
      subtitle: 'Saluti, verb "essere", and definite articles',
      levelBadge: 'A1',
      sections: [
        const GuidebookSection(
          sectionTitle: 'Key Phrases',
          explanation: 'Common Italian greetings and introductions.',
          keyPhrases: [
            KeyPhraseItem(
              targetText: 'Buongiorno! Come sta?',
              translationText: 'Good morning! How are you? (formal)',
            ),
            KeyPhraseItem(
              targetText: 'Ciao! Come stai?',
              translationText: 'Hi! How are you? (informal)',
            ),
            KeyPhraseItem(
              targetText: 'Mi chiamo Marco, piacere.',
              translationText: 'My name is Marco, pleasure to meet you.',
            ),
          ],
        ),
        const GuidebookSection(
          sectionTitle: 'The Verb "Essere" (To Be)',
          explanation: 'Present tense conjugation of essere.',
          table: GrammarTable(
            headers: ['Pronoun', 'Essere (Present)', 'English'],
            rows: [
              ['Io', 'sono', 'I am'],
              ['Tu', 'sei', 'You are'],
              ['Lui / Lei', 'è', 'He / She is'],
              ['Noi', 'siamo', 'We are'],
              ['Voi', 'siete', 'You all are'],
              ['Loro', 'sono', 'They are'],
            ],
          ),
          grammarTip: 'Don\'t confuse "è" (is - with grave accent) and "e" (and - without accent).',
        ),
      ],
    );
  }

  static GuidebookContent _getGenericGuidebook(int unitNumber, String targetLanguage) {
    return GuidebookContent(
      unitNumber: unitNumber,
      title: 'Unit $unitNumber Grammar Guidebook',
      subtitle: 'Key grammar patterns, structures, and vocabulary tips for $targetLanguage',
      levelBadge: 'A1-A2',
      sections: [
        GuidebookSection(
          sectionTitle: 'Key Phrases & Structures',
          explanation: 'Important core expressions for Unit $unitNumber.',
          keyPhrases: [
            KeyPhraseItem(
              targetText: 'Daily Practice in $targetLanguage',
              translationText: 'Mastering active sentences with spaced repetition.',
              phoneticOrNote: 'Focus on natural cadence and pronunciation',
            ),
          ],
        ),
        const GuidebookSection(
          sectionTitle: 'Spaced Repetition Tip',
          explanation:
              'Grammar rules stick best when connected to real sentence contexts rather than isolated tables. Review sentences daily to convert declarative rules into intuitive muscle memory.',
          grammarTip: 'Use Turtle Mode (🐢) in lessons to hear phonetics slowly before speaking!',
        ),
      ],
    );
  }
}
