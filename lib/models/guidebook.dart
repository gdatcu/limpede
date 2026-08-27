class KeyPhraseItem {
  final String targetText;
  final String translationText;
  final String? phoneticOrNote;

  const KeyPhraseItem({
    required this.targetText,
    required this.translationText,
    this.phoneticOrNote,
  });
}

class GrammarTable {
  final List<String> headers;
  final List<List<String>> rows;

  const GrammarTable({
    required this.headers,
    required this.rows,
  });
}

class GuidebookSection {
  final String sectionTitle;
  final String explanation;
  final List<KeyPhraseItem> keyPhrases;
  final GrammarTable? table;
  final String? grammarTip;

  const GuidebookSection({
    required this.sectionTitle,
    required this.explanation,
    this.keyPhrases = const [],
    this.table,
    this.grammarTip,
  });
}

class GuidebookContent {
  final int unitNumber;
  final String title;
  final String subtitle;
  final String levelBadge;
  final List<GuidebookSection> sections;

  const GuidebookContent({
    required this.unitNumber,
    required this.title,
    required this.subtitle,
    required this.levelBadge,
    required this.sections,
  });
}
