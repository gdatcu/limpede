import 'dart:math' as math;
import '../models/mascot_character.dart';

enum MascotDialogueTrigger {
  lessonStart,
  correctAnswer,
  wrongAnswer,
  streak3,
  streak5,
  streak10,
  speedBonus,
  idleTap,
  lessonComplete,
  mistakesWorkout,
  matchMadness,
}

class MascotDialogueEngine {
  static final math.Random _random = math.Random();

  /// Retrieve a personality-tailored, localized dialogue quote
  static String getQuote({
    required MascotId mascotId,
    required MascotDialogueTrigger trigger,
    String nativeLanguage = 'English',
    int? customStreak,
  }) {
    final lang = nativeLanguage.trim().toLowerCase();
    final isRomanian = lang.startsWith('ro');
    final isSpanish = lang.startsWith('es');
    final isFrench = lang.startsWith('fr');
    final isGerman = lang.startsWith('de');

    switch (mascotId) {
      case MascotId.pede:
        return _getPedeQuote(trigger, isRomanian, isSpanish, isFrench, isGerman, customStreak);
      case MascotId.nyx:
        return _getNyxQuote(trigger, isRomanian, isSpanish, isFrench, isGerman, customStreak);
      case MascotId.volta:
        return _getVoltaQuote(trigger, isRomanian, isSpanish, isFrench, isGerman, customStreak);
      case MascotId.kora:
        return _getKoraQuote(trigger, isRomanian, isSpanish, isFrench, isGerman, customStreak);
      case MascotId.boba:
        return _getBobaQuote(trigger, isRomanian, isSpanish, isFrench, isGerman, customStreak);
    }
  }

  // --- PEDE (⚡💧 The Curious Spark: Balanced, encouraging, clear) ---
  static String _getPedeQuote(
      MascotDialogueTrigger trigger, bool isRo, bool isEs, bool isFr, bool isDe, int? streak) {
    if (isRo) {
      switch (trigger) {
        case MascotDialogueTrigger.lessonStart:
          return _pick(['Să facem lecția limpede! ⚡', 'Gata de acțiune? Pas cu pas! 💧', 'Concentrează-te și vom reuși! ⚡']);
        case MascotDialogueTrigger.correctAnswer:
          return _pick(['Excelent! ⚡', 'Corect și limpede! 💧', 'Exact așa! ✨', 'Foarte bine! 🎯']);
        case MascotDialogueTrigger.wrongAnswer:
          return _pick(['Nu-i nimic, repetarea aduce claritate! 💡', 'Din greșeli învățăm cel mai bine! 💧', 'Aproape! Data viitoare iese perfect! ⚡']);
        case MascotDialogueTrigger.streak3:
          return '3 la rând! Începe să curgă fluid! ⚡💧';
        case MascotDialogueTrigger.streak5:
          return '5 la rând! Ești de neoprit! 🔥⚡';
        case MascotDialogueTrigger.streak10:
          return '10 LA RÂND! Claritate maximă! 🌟💎';
        case MascotDialogueTrigger.speedBonus:
          return 'Viteză fulgerătoare! ⚡⚡';
        case MascotDialogueTrigger.idleTap:
          return _pick(['Salut! Sunt Pede ⚡💧', 'Atinge cardurile cu încredere!', 'Fiecare cuvânt te aduce mai aproape de fluență! ✨']);
        case MascotDialogueTrigger.lessonComplete:
          return 'Lecție completată cu brio! Superb! 🎉💧';
        case MascotDialogueTrigger.mistakesWorkout:
          return 'Curățăm toate greșelile din memorie! 🧹⚡';
        case MascotDialogueTrigger.matchMadness:
          return 'Viteza e cheia! Potrivește fulgerător! ⚡';
      }
    }

    // Default English
    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        return _pick(['Let\'s make it crystal clear! ⚡', 'Ready to flow? Step by step! 💧', 'Focus up, we\'ve got this! ⚡']);
      case MascotDialogueTrigger.correctAnswer:
        return _pick(['Spot on! ⚡', 'Crystal clear! 💧', 'Brilliant! ✨', 'Nailed it! 🎯']);
      case MascotDialogueTrigger.wrongAnswer:
        return _pick(['No worries! Mistakes build neural pathways! 💡', 'Repetition is the mother of mastery! 💧', 'Close one! You\'ll get it next time! ⚡']);
      case MascotDialogueTrigger.streak3:
        return '3 in a row! You\'re in the flow! ⚡💧';
      case MascotDialogueTrigger.streak5:
        return '5 in a row! Unstoppable streak! 🔥⚡';
      case MascotDialogueTrigger.streak10:
        return '10 IN A ROW! Master level clarity! 🌟💎';
      case MascotDialogueTrigger.speedBonus:
        return 'Lightning reflexes! ⚡⚡';
      case MascotDialogueTrigger.idleTap:
        return _pick(['Hey there! I\'m Pede ⚡💧', 'Tap away with confidence!', 'Every sentence gets you closer to fluency! ✨']);
      case MascotDialogueTrigger.lessonComplete:
        return 'Lesson cleared in style! High five! 🎉💧';
      case MascotDialogueTrigger.mistakesWorkout:
        return 'Let\'s turn those tricky mistakes into strengths! 🧹⚡';
      case MascotDialogueTrigger.matchMadness:
        return 'Speed is key! Match with lightning pace! ⚡';
    }
  }

  // --- NYX (🌙🔮 The Sarcastic Polyglot: Deadpan, witty, sharp) ---
  static String _getNyxQuote(
      MascotDialogueTrigger trigger, bool isRo, bool isEs, bool isFr, bool isDe, int? streak) {
    if (isRo) {
      switch (trigger) {
        case MascotDialogueTrigger.lessonStart:
          return _pick(['Să vedem dacă ai învățat ceva. 🌙', 'Nu mă face să adorm aici. 🔮', 'Fii atent, nu ghici la nimereală.']);
        case MascotDialogueTrigger.correctAnswer:
          return _pick(['Corect. Sunt moderat impresionată. 🌙', 'Nu-i rău deloc.', 'Se pare că ai fost atent.', 'Acceptabil. Foarte acceptabil. ✨']);
        case MascotDialogueTrigger.wrongAnswer:
          return _pick(['Ei bine... nu chiar așa. 🔮', 'Nu ghici, citește atent.', 'Respiră și gândește înainte să apeși. 🌙']);
        case MascotDialogueTrigger.streak3:
          return '3 la rând. Ai început să te încălzești. 🌙';
        case MascotDialogueTrigger.streak5:
          return '5 la rând. Bine, chiar mă impresionezi acum. 🔮';
        case MascotDialogueTrigger.streak10:
          return '10 la rând?! Cine ești și ce ai făcut cu începătorul? 🌟';
        case MascotDialogueTrigger.speedBonus:
          return 'Rapid. Sper că n-a fost doar noroc. ⚡';
        case MascotDialogueTrigger.idleTap:
          return _pick(['Mă deranjezi în timp ce meditez. 🌙', 'Sunt Nyx. Vorbesc 12 limbi, tu câte?', 'Mai puțin atins, mai mult exersat. 🔮']);
        case MascotDialogueTrigger.lessonComplete:
          return 'Ai supraviețuit lecției. Felicitări sincere. 🌙🎉';
        case MascotDialogueTrigger.mistakesWorkout:
          return 'Timpul să-ți repari micile greșeli. Fără scuze. 🔮';
        case MascotDialogueTrigger.matchMadness:
          return 'Mișcă-ți degetele, ceasul ticăie! 🌙';
      }
    }

    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        return _pick(['Let\'s see if you actually studied. 🌙', 'Try not to embarrass us today. 🔮', 'Focus. No wild guessing.']);
      case MascotDialogueTrigger.correctAnswer:
        return _pick(['Correct. I am mildly impressed. 🌙', 'Not bad at all.', 'Looks like you were actually paying attention.', 'Acceptable. Quite acceptable. ✨']);
      case MascotDialogueTrigger.wrongAnswer:
        return _pick(['Well... that was certainly a choice. 🔮', 'Don\'t guess, read the prompt.', 'Take a breath and think first. 🌙']);
      case MascotDialogueTrigger.streak3:
        return '3 in a row. You\'re finally warming up. 🌙';
      case MascotDialogueTrigger.streak5:
        return '5 in a row. Okay, now you\'re showing off. 🔮';
      case MascotDialogueTrigger.streak10:
        return '10 in a row?! Who are you and what did you do with the beginner? 🌟';
      case MascotDialogueTrigger.speedBonus:
        return 'Fast. Hopefully not just lucky. ⚡';
      case MascotDialogueTrigger.idleTap:
        return _pick(['You\'re interrupting my train of thought. 🌙', 'I\'m Nyx. I speak 12 languages. You?', 'Less poking, more studying. 🔮']);
      case MascotDialogueTrigger.lessonComplete:
        return 'You survived the lesson. Genuine congratulations. 🌙🎉';
      case MascotDialogueTrigger.mistakesWorkout:
        return 'Time to confront your past errors. No excuses. 🔮';
      case MascotDialogueTrigger.matchMadness:
        return 'Fingers moving! The timer doesn\'t care about your feelings. 🌙';
    }
  }

  // --- VOLTA (⚡🔥 The Hype Dynamo: High energy, explosive, competitive) ---
  static String _getVoltaQuote(
      MascotDialogueTrigger trigger, bool isRo, bool isEs, bool isFr, bool isDe, int? streak) {
    if (isRo) {
      switch (trigger) {
        case MascotDialogueTrigger.lessonStart:
          return _pick(['SĂ-I DĂM DRUMUL! ENERGIE MAXIMĂ! 🔥⚡', 'ASTĂZI ZDROBIM LECȚIA! 🚀', 'PREGĂTEȘTE-TE DE VITEZĂ! ⚡']);
        case MascotDialogueTrigger.correctAnswer:
          return _pick(['BOOM! EXACT! 🔥', 'PERFECT! CONTINUĂ AȘA! ⚡', 'IMPECABIL! 🚀', 'BAM! REUȘITĂ CURATĂ! ✨']);
        case MascotDialogueTrigger.wrongAnswer:
          return _pick(['NU TE OPRI! ÎNTOARCE SCORUL ACUM! 🔥', 'TRECEM PESTE! RĂZBUNĂM GREȘEALA! ⚡', 'ENERGIE! RĂSPUNDE CU FORȚĂ! 🚀']);
        case MascotDialogueTrigger.streak3:
          return '3 LA RÂND! TE APRINZI! 🔥⚡';
        case MascotDialogueTrigger.streak5:
          return '5 LA RÂND! ABSOLUT SPECTACULOS! 🚀🔥';
        case MascotDialogueTrigger.streak10:
          return '10 LA RÂND! MODUL DIVIN ACTIVAT! ⚡💥🔥';
        case MascotDialogueTrigger.speedBonus:
          return 'VITEZĂ DE FORMULA 1! ⚡🏁';
        case MascotDialogueTrigger.idleTap:
          return _pick(['VOLTA E NICIODATĂ OBOSIT! ⚡🔥', 'HAI CU COMBO-UL! 🚀', 'SIMȚI ENERGIA?! 💥']);
        case MascotDialogueTrigger.lessonComplete:
          return 'VICTORIE TOTALĂ! EXTRAORDINAR! 🏆🎉🔥';
        case MascotDialogueTrigger.mistakesWorkout:
          return 'DISTURGEM TOATE GREȘELILE! FĂRĂ MILĂ! 🔥';
        case MascotDialogueTrigger.matchMadness:
          return 'FOC LA GHEGHE! POTRIVEȘTE TOT! ⚡🔥🚀';
      }
    }

    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        return _pick(['LET\'S GOOOO! MAXIMUM HYPE! 🔥⚡', 'TIME TO CRUSH THIS LESSON! 🚀', 'WARP SPEED ENGAGED! ⚡']);
      case MascotDialogueTrigger.correctAnswer:
        return _pick(['BOOM! EXACTLY! 🔥', 'PERFECT! KEEP ROLLING! ⚡', 'FLAWLESS! 🚀', 'BAM! PURE POWER! ✨']);
      case MascotDialogueTrigger.wrongAnswer:
        return _pick(['DON\'T STOP! BOUNCE RIGHT BACK! 🔥', 'SHAKE IT OFF! WIN IT ON THE NEXT ONE! ⚡', 'ENERGY UP! ATTACK THE NEXT CARD! 🚀']);
      case MascotDialogueTrigger.streak3:
        return '3 STREAK! YOU\'RE HEATING UP! 🔥⚡';
      case MascotDialogueTrigger.streak5:
        return '5 STREAK! ABSOLUTE CINEMA! 🚀🔥';
      case MascotDialogueTrigger.streak10:
        return '10 STREAK! GOD-TIER COMBO! ⚡💥🔥';
      case MascotDialogueTrigger.speedBonus:
        return 'MACH 10 SPEED! ⚡🏁';
      case MascotDialogueTrigger.idleTap:
        return _pick(['VOLTA NEVER SLEEPS! ⚡🔥', 'LET\'S BUILD THAT STREAK! 🚀', 'FEEL THE ELECTRICITY?! 💥']);
      case MascotDialogueTrigger.lessonComplete:
        return 'TOTAL VICTORY! S-RANK PERFORMANCE! 🏆🎉🔥';
      case MascotDialogueTrigger.mistakesWorkout:
        return 'OBLITERATE THOSE MISTAKES! NO MERCY! 🔥';
      case MascotDialogueTrigger.matchMadness:
        return 'SPEED RUN TIME! BLITZ THE BOARD! ⚡🔥🚀';
    }
  }

  // --- KORA (🌿💎 The Zen Sage: Calming, serene, thoughtful) ---
  static String _getKoraQuote(
      MascotDialogueTrigger trigger, bool isRo, bool isEs, bool isFr, bool isDe, int? streak) {
    if (isRo) {
      switch (trigger) {
        case MascotDialogueTrigger.lessonStart:
          return _pick(['Respiră adânc. Mintea limpede învață ușor. 🌿', 'Un pas mic în fiecare zi devine o călătorie măreață. 💎', 'Fii prezent cu fiecare cuvânt. 🍃']);
        case MascotDialogueTrigger.correctAnswer:
          return _pick(['Frumos și armonios. 🌿', 'Mintea ta este limpede. 💎', 'Înțelegerea ta crește. ✨', 'Un progres sincer și curat. 🍃']);
        case MascotDialogueTrigger.wrongAnswer:
          return _pick(['Greșelile sunt doar semințe ale înțelepciunii. 🌿', 'Nu te grăbi. Claritatea vine din răbdare. 💎', 'Observă nuanța și mergi înainte cu seninătate. 🍃']);
        case MascotDialogueTrigger.streak3:
          return '3 răspunsuri armonioase. Fluxul tău este liniștit. 🌿';
        case MascotDialogueTrigger.streak5:
          return '5 la rând. Concentrarea ta este puternică precum cristalul. 💎';
        case MascotDialogueTrigger.streak10:
          return '10 la rând. O măiestrie deplină și calmă. 🌟🌿';
        case MascotDialogueTrigger.speedBonus:
          return 'Intuiție pură și fără efort. 🍃';
        case MascotDialogueTrigger.idleTap:
          return _pick(['Pacea să fie cu tine. Sunt Kora. 🌿', 'Învățarea este o grădină care înflorește zilnic. 💎', 'Fiecare clipă este o oportunitate de creștere. 🍃']);
        case MascotDialogueTrigger.lessonComplete:
          return 'O sesiune plină de armonie și învățare. Felicitări. 🌿💎';
        case MascotDialogueTrigger.mistakesWorkout:
          return 'Să îngrijim conceptele care au nevoie de atenție. 🌿';
        case MascotDialogueTrigger.matchMadness:
          return 'Rămâi centrat în mijlocul vitezei. 💎';
      }
    }

    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        return _pick(['Breathe deeply. A calm mind learns effortlessly. 🌿', 'A small step every day creates a grand journey. 💎', 'Be fully present with every phrase. 🍃']);
      case MascotDialogueTrigger.correctAnswer:
        return _pick(['Beautiful and harmonious. 🌿', 'Your clarity shines through. 💎', 'Wisdom is taking root. ✨', 'Graceful progress. 🍃']);
      case MascotDialogueTrigger.wrongAnswer:
        return _pick(['Mistakes are merely the seeds of mastery. 🌿', 'Take your time. Patience creates permanence. 💎', 'Observe the pattern with a peaceful mind. 🍃']);
      case MascotDialogueTrigger.streak3:
        return '3 harmonious answers. Your flow is gentle and steady. 🌿';
      case MascotDialogueTrigger.streak5:
        return '5 in a row. Your focus is as resilient as jade. 💎';
      case MascotDialogueTrigger.streak10:
        return '10 in a row. True calm mastery. 🌟🌿';
      case MascotDialogueTrigger.speedBonus:
        return 'Effortless intuition. 🍃';
      case MascotDialogueTrigger.idleTap:
        return _pick(['Peace to you. I am Kora. 🌿', 'Learning is a garden that blooms every day. 💎', 'Every moment holds space for growth. 🍃']);
      case MascotDialogueTrigger.lessonComplete:
        return 'A session filled with harmony and wisdom. Well done. 🌿💎';
      case MascotDialogueTrigger.mistakesWorkout:
        return 'Let us nurture the concepts that need gentle care. 🌿';
      case MascotDialogueTrigger.matchMadness:
        return 'Stay centered even in the heart of speed. 💎';
    }
  }

  // --- BOBA (🫧🧁 The Cheerful Novice: Sweet, bouncy, enthusiastic) ---
  static String _getBobaQuote(
      MascotDialogueTrigger trigger, bool isRo, bool isEs, bool isFr, bool isDe, int? streak) {
    if (isRo) {
      switch (trigger) {
        case MascotDialogueTrigger.lessonStart:
          return _pick(['Ieee! Hai să învățăm cuvinte noi! 🫧', 'Sunt așa entuziasmat! Hai să începem! 🧁', 'Suntem o echipă! Reușim împreună! 💖']);
        case MascotDialogueTrigger.correctAnswer:
          return _pick(['YAAAAY! Ai știut! 🫧', 'Bate palma! ✋💖', 'Super tare! 🎉', 'Ești cel mai bun! ✨']);
        case MascotDialogueTrigger.wrongAnswer:
          return _pick(['Nu plânge! Încercăm din nou împreună! 🫧', 'Îți dau o îmbrățișare mare! Continuăm! 💖', 'Data viitoare nimerești sigur! 🧁']);
        case MascotDialogueTrigger.streak3:
          return '3 la rând! Uite câte bule colorate! 🫧💖';
        case MascotDialogueTrigger.streak5:
          return '5 la rând! Bate zece! ✋✋🎉';
        case MascotDialogueTrigger.streak10:
          return '10 LA RÂND! Petrecere cu buleee! 🫧🥳💖';
        case MascotDialogueTrigger.speedBonus:
          return 'Uau, ce degete rapide! ⚡🫧';
        case MascotDialogueTrigger.idleTap:
          return _pick(['Boba te iubește! 🫧💖', 'Poc! Ai spart o bulă! 🧁', 'Facem o pauză de prăjiturele? 🍪']);
        case MascotDialogueTrigger.lessonComplete:
          return 'AM TERMINAT! Ești un campion! 🥳🧁🎉';
        case MascotDialogueTrigger.mistakesWorkout:
          return 'Reparăm micile greșeli cu dragoste! 🫧💖';
        case MascotDialogueTrigger.matchMadness:
          return 'Bule peste tot! Rapid, rapid! 🫧⚡';
      }
    }

    switch (trigger) {
      case MascotDialogueTrigger.lessonStart:
        return _pick(['Yaaay! Let\'s learn fun new words! 🫧', 'I\'m so excited! Let\'s do this! 🧁', 'We\'re a team! We can do anything! 💖']);
      case MascotDialogueTrigger.correctAnswer:
        return _pick(['YAAAAY! You got it! 🫧', 'High five! ✋💖', 'Super awesome! 🎉', 'You\'re the best! ✨']);
      case MascotDialogueTrigger.wrongAnswer:
        return _pick(['Don\'t be sad! We\'ll try again together! 🫧', 'Sending you a big warm hug! Keep going! 💖', 'You\'ll get it next time for sure! 🧁']);
      case MascotDialogueTrigger.streak3:
        return '3 in a row! Look at all the bubbles! 🫧💖';
      case MascotDialogueTrigger.streak5:
        return '5 in a row! Double high five! ✋✋🎉';
      case MascotDialogueTrigger.streak10:
        return '10 IN A ROW! Bubble party time! 🫧🥳💖';
      case MascotDialogueTrigger.speedBonus:
        return 'Whoa, speedy fingers! ⚡🫧';
      case MascotDialogueTrigger.idleTap:
        return _pick(['Boba loves you! 🫧💖', 'Pop! You tapped a bubble! 🧁', 'Time for a cookie break soon? 🍪']);
      case MascotDialogueTrigger.lessonComplete:
        return 'WE DID IT! You\'re an absolute superstar! 🥳🧁🎉';
      case MascotDialogueTrigger.mistakesWorkout:
        return 'Let\'s fix those tricky cards with lots of love! 🫧💖';
      case MascotDialogueTrigger.matchMadness:
        return 'Bubbles popping everywhere! Fast, fast! 🫧⚡';
    }
  }

  static String _pick(List<String> options) {
    return options[_random.nextInt(options.length)];
  }
}
