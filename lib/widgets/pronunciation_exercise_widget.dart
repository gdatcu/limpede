import 'package:flutter/material.dart';
import '../services/speech_service.dart';
import '../services/tts_service.dart';
import 'interactive_hint_sentence.dart';

class PronunciationExerciseWidget extends StatefulWidget {
  final String targetSentence;
  final String nativeTranslation;
  final String languageCode;
  final ValueChanged<bool> onCompleted;

  const PronunciationExerciseWidget({
    super.key,
    required this.targetSentence,
    required this.nativeTranslation,
    required this.languageCode,
    required this.onCompleted,
  });

  @override
  State<PronunciationExerciseWidget> createState() => _PronunciationExerciseWidgetState();
}

class _PronunciationExerciseWidgetState extends State<PronunciationExerciseWidget>
    with SingleTickerProviderStateMixin {
  final SpeechRecognitionService _speechService = SpeechRecognitionService();
  final TtsService _ttsService = TtsService();

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  String _spokenText = '';
  int _accuracyScore = 0;
  bool _isListening = false;
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _speechService.initialize();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _speechService.stopListening();
    super.dispose();
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

  Future<void> _toggleListening() async {
    if (_hasSubmitted) return;

    if (_isListening) {
      await _speechService.stopListening();
      setState(() => _isListening = false);
    } else {
      setState(() {
        _isListening = true;
        _spokenText = 'Listening...';
      });

      await _speechService.startListening(
        targetLanguage: widget.languageCode,
        onResult: (text, confidence) {
          if (mounted) {
            final score = SpeechRecognitionService.calculateSimilarity(
              text,
              widget.targetSentence,
            );

            setState(() {
              _spokenText = text;
              _accuracyScore = score;
            });

            // If excellent match, automatically validate
            if (score >= 75 && !_hasSubmitted) {
              _handleSubmit(true);
            }
          }
        },
      );
    }
  }

  void _handleSubmit(bool isPassed) {
    if (_hasSubmitted) return;
    _speechService.stopListening();

    setState(() {
      _hasSubmitted = true;
      _isListening = false;
    });

    widget.onCompleted(isPassed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPassed = _accuracyScore >= 70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Prompt Header Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.mic, color: Colors.purple, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Speak this sentence',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Normal Audio Button 🔊
                    IconButton(
                      icon: Icon(Icons.volume_up_rounded, color: theme.colorScheme.primary, size: 26),
                      tooltip: 'Listen',
                      onPressed: _speakNormal,
                    ),

                    // Turtle Mode Button 🐢 (0.5x)
                    IconButton(
                      icon: const Text('🐢', style: TextStyle(fontSize: 22)),
                      tooltip: 'Turtle Mode (Slow)',
                      onPressed: _speakSlowly,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Interactive Hint Target Sentence
                InteractiveHintSentence(
                  text: widget.targetSentence,
                  languageCode: widget.languageCode,
                  textStyle: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  widget.nativeTranslation,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Spoken Output & Match Score Meter
        if (_spokenText.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _accuracyScore >= 70
                  ? Colors.green.withValues(alpha: 0.12)
                  : _accuracyScore >= 40
                      ? Colors.amber.withValues(alpha: 0.12)
                      : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _accuracyScore >= 70
                    ? Colors.green
                    : _accuracyScore >= 40
                        ? Colors.amber
                        : theme.colorScheme.outlineVariant,
              ),
            ),
            child: Column(
              children: [
                Text(
                  '"$_spokenText"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _accuracyScore >= 70
                          ? Icons.check_circle
                          : _accuracyScore >= 40
                              ? Icons.info
                              : Icons.mic_none,
                      size: 16,
                      color: _accuracyScore >= 70
                          ? Colors.green
                          : _accuracyScore >= 40
                              ? Colors.amber.shade700
                              : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$_accuracyScore% Pronunciation Match',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _accuracyScore >= 70
                            ? Colors.green
                            : _accuracyScore >= 40
                                ? Colors.amber.shade800
                                : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        const Spacer(),

        // Animated Microphone Recording Button
        Center(
          child: GestureDetector(
            onTap: _toggleListening,
            child: ScaleTransition(
              scale: _isListening ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _isListening
                        ? [Colors.redAccent, Colors.pink]
                        : [theme.colorScheme.primary, theme.colorScheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isListening ? Colors.redAccent : theme.colorScheme.primary)
                          .withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: _isListening ? 4 : 0,
                    ),
                  ],
                ),
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none_rounded,
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            _isListening ? 'Listening... Tap to stop' : 'Tap microphone to speak',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Spacer(),

        // Action Buttons
        if (!_hasSubmitted)
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _handleSubmit(true), // Skip / Can't speak now
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text("Can't speak now"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _spokenText.isNotEmpty && _spokenText != 'Listening...'
                      ? () => _handleSubmit(isPassed)
                      : null,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                  child: const Text('Submit Speech', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
