import 'package:flutter/material.dart';
import '../services/dictionary_service.dart';

class InteractiveHintSentence extends StatelessWidget {
  final String text;
  final String languageCode;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const InteractiveHintSentence({
    super.key,
    required this.text,
    required this.languageCode,
    this.textStyle,
    this.textAlign = TextAlign.start,
  });

  void _showWordHint(BuildContext context, String word, WordHint hint) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    word,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (hint.partOfSpeech != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hint.partOfSpeech!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                hint.translation,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (hint.grammarTip != null) ...[
                const SizedBox(height: 6),
                Text(
                  hint.grammarTip!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.tertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = textStyle ?? theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold);

    // Split text into word tokens and whitespace/punctuation
    final regex = RegExp(r"([\p{L}\p{N}\-']+)|([^\p{L}\p{N}\-']+)", unicode: true);
    final matches = regex.allMatches(text).toList();

    return Wrap(
      alignment: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: matches.map((match) {
        final token = match.group(0) ?? '';
        final isWord = RegExp(r"[\p{L}\p{N}]", unicode: true).hasMatch(token);

        if (!isWord) {
          return Text(token, style: style);
        }

        final hint = DictionaryService.lookup(token, languageCode);

        return GestureDetector(
          onTap: () {
            if (hint != null) {
              _showWordHint(context, token, hint);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Text(
              token,
              style: style,
            ),
          ),
        );
      }).toList(),
    );
  }
}
