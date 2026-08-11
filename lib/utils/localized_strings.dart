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

  static String getSrsReviewTitle(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Revizuire Zilnică SRS';
      case 'fr':
        return 'Révision Quotidienne SRS';
      case 'de':
        return 'Tägliche Wiederholung SRS';
      case 'es':
        return 'Repaso Diario SRS';
      case 'it':
        return 'Ripasso Giornaliero SRS';
      case 'pt':
        return 'Revisão Diária SRS';
      case 'ru':
        return 'Ежедневное повторение SRS';
      case 'ja':
        return 'SRS デイリー復習';
      case 'en':
      default:
        return 'SRS Daily Review';
    }
  }

  static String getCustomTopicTitle(String nativeLanguage) {
    final code = LanguageUtils.normalizeLanguageCode(nativeLanguage);
    switch (code) {
      case 'ro':
        return 'Asistent Teme Personalizate';
      case 'fr':
        return 'Assistant Thème Personnalisé';
      case 'de':
        return 'Benutzerdefinierte Themen-Hilfe';
      case 'es':
        return 'Asistente de Temas Personalizados';
      case 'it':
        return 'Assistente Argomenti Personalizzati';
      case 'pt':
        return 'Assistente de Tópicos Personalizados';
      case 'ru':
        return 'Мастер пользовательских тем';
      case 'ja':
        return 'カスタムトピックヘルパー';
      case 'en':
      default:
        return 'Custom Topic Helper';
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
