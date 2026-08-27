import 'package:flutter_test/flutter_test.dart';
import 'package:limpede/services/guidebook_service.dart';

void main() {
  group('Unit Grammar Guidebook Tests', () {
    test('Spanish Unit 1 Guidebook returns rich sections and tables', () {
      final guidebook = GuidebookService.getGuidebook(
        unitNumber: 1,
        targetLanguage: 'Spanish',
        nativeLanguage: 'English',
      );

      expect(guidebook.unitNumber, 1);
      expect(guidebook.title, contains('Foundations'));
      expect(guidebook.levelBadge, 'A1');
      expect(guidebook.sections, isNotEmpty);

      // Verify key phrases section
      final keyPhrasesSection = guidebook.sections.firstWhere((s) => s.keyPhrases.isNotEmpty);
      expect(keyPhrasesSection.keyPhrases, isNotEmpty);
      expect(keyPhrasesSection.keyPhrases.any((p) => p.targetText.contains('Hola')), true);

      // Verify grammar table
      final tableSection = guidebook.sections.firstWhere((s) => s.table != null);
      expect(tableSection.table!.headers, contains('Ser (Present)'));
      expect(tableSection.table!.rows, isNotEmpty);
    });

    test('German Unit 1 Guidebook returns Der, Die, Das table and Sein conjugation', () {
      final guidebook = GuidebookService.getGuidebook(
        unitNumber: 1,
        targetLanguage: 'German',
        nativeLanguage: 'Romanian',
      );

      expect(guidebook.unitNumber, 1);
      expect(guidebook.title, contains('German Basics'));
      expect(guidebook.sections.any((s) => s.sectionTitle.contains('Der, Die, Das')), true);
    });

    test('French Unit 1 Guidebook returns Être conjugation and politeness rules', () {
      final guidebook = GuidebookService.getGuidebook(
        unitNumber: 1,
        targetLanguage: 'French',
        nativeLanguage: 'English',
      );

      expect(guidebook.title, contains('Foundations'));
      expect(guidebook.sections.any((s) => s.sectionTitle.contains('Être')), true);
    });

    test('Generic Guidebook fallback for arbitrary languages', () {
      final guidebook = GuidebookService.getGuidebook(
        unitNumber: 8,
        targetLanguage: 'Swedish',
        nativeLanguage: 'English',
      );

      expect(guidebook.unitNumber, 8);
      expect(guidebook.title, contains('Unit 8 Grammar Guidebook'));
      expect(guidebook.sections, isNotEmpty);
    });
  });
}
