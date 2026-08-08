import 'package:flutter/material.dart';

class SentenceBuilderWidget extends StatefulWidget {
  final List<String> wordBank;
  final String correctAnswer;
  final ValueChanged<bool> onCompleted;

  const SentenceBuilderWidget({
    super.key,
    required this.wordBank,
    required this.correctAnswer,
    required this.onCompleted,
  });

  @override
  State<SentenceBuilderWidget> createState() => _SentenceBuilderWidgetState();
}

class _SentenceBuilderWidgetState extends State<SentenceBuilderWidget> {
  late List<String> _availableWords;
  final List<String> _selectedWords = [];
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _availableWords = List.from(widget.wordBank)..shuffle();
  }

  void _selectWord(String word) {
    if (_hasSubmitted) return;
    setState(() {
      _availableWords.remove(word);
      _selectedWords.add(word);
    });
  }

  void _unselectWord(String word) {
    if (_hasSubmitted) return;
    setState(() {
      _selectedWords.remove(word);
      _availableWords.add(word);
    });
  }

  void _checkAnswer() {
    final userSentence = _selectedWords.join(' ').trim();
    final isCorrect = userSentence.toLowerCase() == widget.correctAnswer.toLowerCase();

    setState(() {
      _hasSubmitted = true;
    });

    widget.onCompleted(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userSentence = _selectedWords.join(' ').trim();
    final isCorrect = userSentence.toLowerCase() == widget.correctAnswer.toLowerCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Drop Area (Sentence Construction Zone)
        Container(
          constraints: const BoxConstraints(minHeight: 100),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hasSubmitted
                ? (isCorrect
                    ? Colors.green.withValues(alpha: 0.15)
                    : theme.colorScheme.errorContainer.withValues(alpha: 0.4))
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hasSubmitted
                  ? (isCorrect ? Colors.green : theme.colorScheme.error)
                  : theme.colorScheme.outlineVariant,
              width: 2,
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedWords.map((word) {
              return ActionChip(
                label: Text(
                  word,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                backgroundColor: theme.colorScheme.primaryContainer,
                onPressed: () => _unselectWord(word),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        Text(
          'Tap words in correct order:',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),

        // Available Word Tiles Bank
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _availableWords.map((word) {
                return OutlinedButton(
                  onPressed: () => _selectWord(word),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        if (!_hasSubmitted)
          FilledButton(
            onPressed: _selectedWords.isNotEmpty ? _checkAnswer : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Check Answer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
