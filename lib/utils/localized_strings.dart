import 'language_utils.dart';

class LocalizedStrings {
  /// Returns a localized instruction header: "Translate into {TargetLanguage}"
  static String getTranslateInto({
    required String nativeLanguage,
    required String targetLanguage,
  }) {
    final nativeCode = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    final targetDisplay = _getLocalizedLanguageName(nativeCode: nativeCode, targetLanguage: targetLanguage);

    switch (nativeCode) {
      case 'ro':
        return 'Traduceți în $targetDisplay:';
      case 'fr':
        return 'Traduisez en $targetDisplay :';
      case 'de':
        return 'Übersetze ins $targetDisplay:';
      case 'es':
        return 'Traduce al $targetDisplay:';
      case 'it':
        return 'Traduci in $targetDisplay:';
      case 'pt':
        return 'Traduza para o $targetDisplay:';
      case 'ru':
        return 'Переведите на $targetDisplay:';
      case 'ja':
        return '$targetDisplayに翻訳してください:';
      case 'en':
      default:
        return 'Translate into $targetDisplay:';
    }
  }

  static String getCheckAnswer(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Verifică';
      case 'fr':
        return 'Vérifier';
      case 'de':
        return 'Überprüfen';
      case 'es':
        return 'Comprobar';
      case 'it':
        return 'Verifica';
      case 'pt':
        return 'Verificar';
      case 'ru':
        return 'Проверить';
      case 'ja':
        return '確認する';
      case 'en':
      default:
        return 'Check Answer';
    }
  }

  static String getContinue(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Continuă';
      case 'fr':
        return 'Continuer';
      case 'de':
        return 'Weiter';
      case 'es':
        return 'Continuar';
      case 'it':
        return 'Continua';
      case 'pt':
        return 'Continuar';
      case 'ru':
        return 'Продолжить';
      case 'ja':
        return '続ける';
      case 'en':
      default:
        return 'Continue';
    }
  }

  static String getExcellent(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Excelent!';
      case 'fr':
        return 'Excellent !';
      case 'de':
        return 'Ausgezeichnet!';
      case 'es':
        return '¡Excelente!';
      case 'it':
        return 'Eccellente!';
      case 'pt':
        return 'Excelente!';
      case 'ru':
        return 'Отлично!';
      case 'ja':
        return '素晴らしい！';
      case 'en':
      default:
        return 'Excellent!';
    }
  }

  static String getIncorrect(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Incorect!';
      case 'fr':
        return 'Incorrect !';
      case 'de':
        return 'Falsch!';
      case 'es':
        return '¡Incorrecto!';
      case 'it':
        return 'Errato!';
      case 'pt':
        return 'Incorreto!';
      case 'ru':
        return 'Неправильно!';
      case 'ja':
        return '不正解です！';
      case 'en':
      default:
        return 'Incorrect';
    }
  }

  static String getDailyReviewTitle(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Recapitulare Zilnică';
      case 'fr':
        return 'Révision Quotidienne';
      case 'de':
        return 'Tägliche Wiederholung';
      case 'es':
        return 'Repaso Diario';
      case 'it':
        return 'Ripasso Giornaliero';
      case 'pt':
        return 'Revisão Diária';
      case 'ru':
        return 'Ежедневное повторение';
      case 'ja':
        return 'デイリー復習';
      case 'en':
      default:
        return 'Daily Review';
    }
  }

  static String getDueItemsSubtext(String nativeLanguage, int count) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    if (count > 0) {
      switch (code) {
        case 'ro':
          return '$count elemente de revizuit astăzi!';
        case 'fr':
          return '$count éléments à réviser aujourd\'hui !';
        case 'de':
          return '$count Elemente heute zu wiederholen!';
        case 'es':
          return '¡$count elementos para repasar hoy!';
        case 'it':
          return '$count elementi da ripassare oggi!';
        case 'pt':
          return '$count itens para revisar hoje!';
        case 'ru':
          return 'Элементов для повторения сегодня: $count!';
        case 'ja':
          return '本日の復習アイテム: $count個';
        case 'en':
        default:
          return '$count items due for review today!';
      }
    } else {
      switch (code) {
        case 'ro':
          return 'Toate recapitulările sunt finalizate pe azi!';
        case 'fr':
          return 'Toutes les révisions sont terminées !';
        case 'de':
          return 'Alle Wiederholungen für heute abgeschlossen!';
        case 'es':
          return '¡Todos los repasos completados por hoy!';
        case 'it':
          return 'Tutti i ripassi completati per oggi!';
        case 'pt':
          return 'Todas as revisões concluídas por hoje!';
        case 'ru':
          return 'Все повторения на сегодня завершены!';
        case 'ja':
          return '本日の復習はすべて完了しました！';
        case 'en':
        default:
          return 'All reviews completed for today! Great job!';
      }
    }
  }

  static String getCustomTopicTitle(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Asistent Teme Personalizate';
      case 'fr':
        return 'Assistant de Thèmes';
      case 'de':
        return 'Themen-Assistent';
      case 'es':
        return 'Asistente de Temas';
      case 'it':
        return 'Assistente Argomenti';
      case 'pt':
        return 'Assistente de Tópicos';
      case 'ru':
        return 'Мастер тем';
      case 'ja':
        return 'カスタムトピック';
      case 'en':
      default:
        return 'Custom Topic Assistant';
    }
  }

  static String getCustomTopicSubtext(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Generează un pachet de teme offline sau la cerere!';
      case 'fr':
        return 'Générez un deck de thèmes !';
      case 'de':
        return 'Erstelle ein eigenes Themendeck!';
      case 'es':
        return '¡Genera un mazo de temas personalizado!';
      case 'it':
        return 'Genera un mazzo personalizzato!';
      case 'pt':
        return 'Gere um baralho de tópicos personalizado!';
      case 'ru':
        return 'Создайте свой набор тем!';
      case 'ja':
        return 'カスタムデッキを生成する！';
      case 'en':
      default:
        return 'Generate a custom topic deck offline or on-demand!';
    }
  }

  static String getBtnCreate(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Creează';
      case 'fr':
        return 'Créer';
      case 'de':
        return 'Erstellen';
      case 'es':
        return 'Crear';
      case 'it':
        return 'Crea';
      case 'pt':
        return 'Criar';
      case 'ru':
        return 'Создать';
      case 'ja':
        return '作成';
      case 'en':
      default:
        return 'Create';
    }
  }

  static String getBtnReview(String nativeLanguage, int count) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    final String label;
    switch (code) {
      case 'ro':
        label = 'Revizuiește';
        break;
      case 'fr':
        label = 'Réviser';
        break;
      case 'de':
        label = 'Wiederholen';
        break;
      case 'es':
        label = 'Repasar';
        break;
      case 'it':
        label = 'Ripassa';
        break;
      case 'pt':
        label = 'Revisar';
        break;
      case 'ru':
        label = 'Повторить';
        break;
      case 'ja':
        label = '復習する';
        break;
      case 'en':
      default:
        label = 'Review';
        break;
    }
    return count > 0 ? '$label ($count)' : label;
  }

  static String getNavLearn(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Învață';
      case 'fr':
        return 'Apprendre';
      case 'de':
        return 'Lernen';
      case 'es':
        return 'Aprender';
      case 'it':
        return 'Impara';
      case 'pt':
        return 'Aprender';
      case 'ru':
        return 'Учить';
      case 'ja':
        return '学習';
      case 'en':
      default:
        return 'Learn';
    }
  }

  static String getNavLeaderboard(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Clasament';
      case 'fr':
        return 'Classement';
      case 'de':
        return 'Bestenliste';
      case 'es':
        return 'Clasificación';
      case 'it':
        return 'Classifica';
      case 'pt':
        return 'Placar';
      case 'ru':
        return 'Рейтинг';
      case 'ja':
        return 'ランキング';
      case 'en':
      default:
        return 'Leaderboard';
    }
  }

  static String getNavProfile(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Profil';
      case 'fr':
        return 'Profil';
      case 'de':
        return 'Profil';
      case 'es':
        return 'Perfil';
      case 'it':
        return 'Profilo';
      case 'pt':
        return 'Perfil';
      case 'ru':
        return 'Профиль';
      case 'ja':
        return 'プロフィール';
      case 'en':
      default:
        return 'Profile';
    }
  }

  static String _getLocalizedLanguageName({
    required String nativeCode,
    required String targetLanguage,
  }) {
    final targetCode = LanguageUtils.normalizeLanguageCode(targetLanguage);

    final Map<String, Map<String, String>> names = {
      'ro': {
        'en': 'engleză',
        'de': 'germană',
        'fr': 'franceză',
        'es': 'spaniolă',
        'it': 'italiană',
        'ro': 'română',
        'pt': 'portugheză',
        'ru': 'rusă',
        'ja': 'japoneză',
      },
      'fr': {
        'en': 'anglais',
        'de': 'allemand',
        'fr': 'français',
        'es': 'espagnol',
        'it': 'italien',
        'ro': 'roumain',
        'pt': 'portugais',
        'ru': 'russe',
        'ja': 'japonais',
      },
      'de': {
        'en': 'Englische',
        'de': 'Deutsche',
        'fr': 'Französische',
        'es': 'Spanische',
        'it': 'Italienische',
        'ro': 'Rumänische',
        'pt': 'Portugiesische',
        'ru': 'Russische',
        'ja': 'Japanische',
      },
      'es': {
        'en': 'inglés',
        'de': 'alemán',
        'fr': 'francés',
        'es': 'español',
        'it': 'italiano',
        'ro': 'rumano',
        'pt': 'portugués',
        'ru': 'ruso',
        'ja': 'japonés',
      },
    };

    final langMap = names[nativeCode];
    if (langMap != null && langMap.containsKey(targetCode)) {
      return langMap[targetCode]!;
    }
    return targetLanguage;
  }
}
