import 'package:flutter/material.dart';
import '../models/guidebook.dart';
import '../services/tts_service.dart';

class GuidebookSheet extends StatelessWidget {
  final GuidebookContent guidebook;
  final String targetLanguage;

  const GuidebookSheet({
    super.key,
    required this.guidebook,
    required this.targetLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tts = TtsService();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Top Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),

          // Header Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.menu_book_rounded, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'UNIT ${guidebook.unitNumber} GUIDEBOOK',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              guidebook.levelBadge,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        guidebook.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        guidebook.subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),

          // Scrollable Sections Content
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: guidebook.sections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final section = guidebook.sections[index];
                return _buildSection(context, section, tts, theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    GuidebookSection section,
    TtsService tts,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                section.sectionTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Explanation text
        Text(
          section.explanation,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.45,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),

        // Key Phrases List
        if (section.keyPhrases.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final phrase in section.keyPhrases)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          phrase.targetText,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          phrase.translationText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (phrase.phoneticOrNote != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            phrase.phoneticOrNote!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.tertiary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Speaker Button 🔊
                  IconButton(
                    icon: Icon(Icons.volume_up_rounded, color: theme.colorScheme.primary, size: 22),
                    tooltip: 'Listen',
                    onPressed: () {
                      tts.speak(
                        text: phrase.targetText,
                        targetLanguage: targetLanguage,
                      );
                    },
                  ),

                  // Turtle Button 🐢
                  IconButton(
                    icon: const Text('🐢', style: TextStyle(fontSize: 18)),
                    tooltip: 'Slow Audio',
                    onPressed: () {
                      tts.speakSlowly(
                        text: phrase.targetText,
                        targetLanguage: targetLanguage,
                      );
                    },
                  ),
                ],
              ),
            ),
        ],

        // Grammar Table
        if (section.table != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: DataTable(
                headingRowColor: WidgetStatePropertyAll(theme.colorScheme.surfaceContainerHighest),
                dataRowColor: WidgetStateProperty.resolveWith((states) {
                  return Colors.transparent;
                }),
                columns: [
                  for (final header in section.table!.headers)
                    DataColumn(
                      label: Text(
                        header,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                ],
                rows: [
                  for (final row in section.table!.rows)
                    DataRow(
                      cells: [
                        for (final cell in row)
                          DataCell(
                            Text(
                              cell,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],

        // Grammar Tip / Common Mistake Box
        if (section.grammarTip != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline_rounded, color: Colors.amber, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.grammarTip!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
