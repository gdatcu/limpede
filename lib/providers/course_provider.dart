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
  /// If learning German as English speaker: returns 'de'.
  /// If learning English as Romanian speaker: returns 'ro' (via Virtual Reverse Swap).
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
    // If native language is set to English and target was English, switch target to German
    String newTarget = state.targetLanguage;
    if (lang == 'English' && newTarget == 'English') {
      newTarget = 'German';
    }
    state = state.copyWith(nativeLanguage: lang, targetLanguage: newTarget);
  }

  void setTargetLanguage(String lang) {
    if (lang == state.targetLanguage) return;
    state = state.copyWith(targetLanguage: lang);
  }

  void setCourse({required String nativeLanguage, required String targetLanguage}) {
    state = CourseState(
      nativeLanguage: nativeLanguage,
      targetLanguage: targetLanguage,
    );
  }
}
