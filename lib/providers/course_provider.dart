import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/language_utils.dart';

part 'course_provider.g.dart';

class CourseState {
  final String nativeLanguage; // e.g. 'English', 'Romanian', 'French', 'German', 'Spanish'
  final String targetLanguage; // e.g. 'German', 'English', 'Spanish', 'French'

  const CourseState({
    this.nativeLanguage = 'English',
    this.targetLanguage = 'German',
  });

  /// Returns true when a non-English speaker is learning English (e.g. Romanian -> English).
  bool get isReverseMode =>
      nativeLanguage.trim().toLowerCase() != 'english' &&
      targetLanguage.trim().toLowerCase() == 'english';

  /// Returns the language code to query in Supabase sentence_pairs.
  /// If isReverseMode == false (English -> Foreign): returns targetLanguage code (e.g. 'de').
  /// If isReverseMode == true (Foreign -> English): returns nativeLanguage code (e.g. 'ro').
  String get queryLanguageCode {
    if (isReverseMode) {
      return LanguageUtils.normalizeLanguageCode(nativeLanguage);
    }
    return LanguageUtils.normalizeLanguageCode(targetLanguage);
  }

  CourseState copyWith({
    String? nativeLanguage,
    String? targetLanguage,
  }) {
    return CourseState(
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}

@riverpod
class CourseStateNotifier extends _$CourseStateNotifier {
  @override
  CourseState build() {
    return const CourseState(
      nativeLanguage: 'English',
      targetLanguage: 'German',
    );
  }

  void setNativeLanguage(String lang) {
    if (lang == state.nativeLanguage) return;
    String newTarget = state.targetLanguage;
    if (lang != 'English') {
      // If user chooses a non-English native language, auto-correct target to English
      newTarget = 'English';
    } else if (newTarget == 'English') {
      // If native language is reset to English and target was English, default target to German
      newTarget = 'German';
    }
    state = CourseState(
      nativeLanguage: lang,
      targetLanguage: newTarget,
    );
  }

  void setTargetLanguage(String lang) {
    if (lang == state.targetLanguage) return;
    String newNative = state.nativeLanguage;
    if (lang != 'English') {
      // If user chooses a non-English target language, auto-correct native to English
      newNative = 'English';
    } else if (newNative == 'English') {
      // If target is set to English and native was English, default native to Romanian for Reverse Mode
      newNative = 'Romanian';
    }
    state = CourseState(
      nativeLanguage: newNative,
      targetLanguage: lang,
    );
  }

  void setCourse({required String nativeLanguage, required String targetLanguage}) {
    if (nativeLanguage != 'English' && targetLanguage != 'English') {
      state = CourseState(
        nativeLanguage: nativeLanguage,
        targetLanguage: 'English',
      );
    } else {
      state = CourseState(
        nativeLanguage: nativeLanguage,
        targetLanguage: targetLanguage,
      );
    }
  }
}
