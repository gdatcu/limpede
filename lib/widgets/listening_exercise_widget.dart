import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class ListeningExerciseWidget extends StatefulWidget {
  final String targetSentence;
  final String nativeTranslation;
  final String languageCode;
  final List<String> distractorWords;
  final ValueChanged<bool> onCompleted;

  const ListeningExerciseWidget({
    super.key,
    required this.targetSentence,
    required this.nativeTranslation,
    required this.languageCode,
    required this.distractorWords,
    required this.onCompleted,
  });

  @override
  State<ListeningExerciseWidget> createState() => _ListeningExerciseWidgetState();
}

class _ListeningExerciseWidgetState extends State<ListeningExerciseWidget> {
  final TtsService _ttsService = TtsService();
  late List<String> _availableWords;
  final List<String> _selectedWords = [];
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    final targetWords = widget.targetSentence
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();

    final allWords = <String>{...targetWords, ...widget.distractorWords}.toList();
    allWords.shuffle();
    _availableWords = allWords;

    // Autoplay audio on mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakNormal();
    });
  }

  void _speakNormal() {
    _ttsService.speak(
      text: widget.targetSentence,
      targetLanguage: widget.languageCode,
    );
  }

  void _speakSlowly() {
    _ttsService.speakSlowly(
      text: widget.targetSentence,
      targetLanguage: widget.languageCode,
    );
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
    final userText = _selectedWords.join(' ').toLowerCase().trim();
    final targetClean = widget.targetSentence
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '')
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    final isCorrect = userText == targetClean;

    setState(() {
      _hasSubmitted = true;
    });

    widget.onCompleted(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userText = _selectedWords.join(' ').toLowerCase().trim();
    final targetClean = widget.targetSentence
        .replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '')
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final isCorrect = userText == targetClean;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Audio Player Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.headphones_rounded, color: Colors.blue, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Tap what you hear',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Audio Play Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Big Speaker Button
                    ElevatedButton.icon(
                      onPressed: _speakNormal,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.volume_up_rounded, size: 28),
                      label: const Text('Play Audio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(width: 12),

                    // Turtle Mode Button 🐢
                    OutlinedButton(
                      onPressed: _speakSlowly,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text('🐢', style: TextStyle(fontSize: 24)),
                          SizedBox(width: 4),
                          Text('0.5x', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),

                // Revealed transcript upon submission
                if (_hasSubmitted) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    widget.targetSentence,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.nativeTranslation,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Construction Zone
        Container(
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _hasSubmitted
                ? (isCorrect
                    ? Colors.green.withValues(alpha: 0.12)
                    : Colors.red.withValues(alpha: 0.12))
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hasSubmitted
                  ? (isCorrect ? Colors.green : Colors.red)
                  : theme.colorScheme.outlineVariant,
              width: 1.5,
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedWords.map((word) {
              return ActionChip(
                label: Text(
                  word,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                backgroundColor: theme.colorScheme.primaryContainer,
                onPressed: () => _unselectWord(word),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Word Bank
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _availableWords.map((word) {
                return OutlinedButton(
                  onPressed: () => _selectWord(word),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Submit Button
        if (!_hasSubmitted)
          FilledButton(
            onPressed: _selectedWords.isNotEmpty ? _checkAnswer : null,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text('Check Audio Answer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
      ],
    );
  }
}
