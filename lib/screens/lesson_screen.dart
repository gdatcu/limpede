import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/lesson_catalog.dart';
import '../models/srs_models.dart';
import '../providers/feedback_provider.dart';
import '../providers/lesson_provider.dart';
import '../providers/srs_lesson_provider.dart';
import '../widgets/widgets.dart';

class LessonScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final String targetLanguage;
  final bool isCustomAiTopic;
  final bool isSrsReview;

  const LessonScreen({
    super.key,
    required this.lessonId,
    this.targetLanguage = 'Spanish',
    this.isCustomAiTopic = false,
    this.isSrsReview = false,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  int _currentIndex = 0;
  int _hearts = 5;
  String? _selectedOption;
  bool _hasSubmitted = false;
  bool _hasCompletedLesson = false;
  List<String> _currentOptions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(srsLessonControllerProvider.notifier).loadLessonDeck(
            topic: widget.lessonId,
            targetLanguage: widget.targetLanguage,
            isSrsReviewSession: widget.isSrsReview,
          );
    });
  }

  void _generateOptions(SentencePair currentPair, List<SentencePair> deck) {
    if (_currentOptions.isNotEmpty) return;

    final catalogPairs = LessonCatalog.getSentencePairs(
      topic: widget.lessonId,
      targetLanguage: widget.targetLanguage,
    );

    final Set<String> optionsSet = {currentPair.targetText};

    // Add targetTexts from other items in deck
    for (var p in deck) {
      if (p.targetText != currentPair.targetText) {
        optionsSet.add(p.targetText);
      }
      if (optionsSet.length >= 4) break;
    }

    // Add from catalog if needed
    for (var p in catalogPairs) {
      if (p.targetText != currentPair.targetText) {
        optionsSet.add(p.targetText);
      }
      if (optionsSet.length >= 4) break;
    }

    // Add fallback options if needed
    final fallbacks = [
      'Gracias por la ayuda',
      'Hasta luego amigo',
      'Buenos días a todos',
      'Por favor otra vez',
    ];
    for (var f in fallbacks) {
      if (optionsSet.length >= 4) break;
      if (f != currentPair.targetText) optionsSet.add(f);
    }

    final list = optionsSet.toList();
    list.shuffle(math.Random(currentPair.id.hashCode));
    _currentOptions = list;
  }

  void _speakText(String text) {
    final tts = ref.read(ttsServiceProvider);
    tts.speak(text: text, targetLanguage: widget.targetLanguage);
  }

  void _openGrammarExplainSheet(SentencePair pair, String userAnswer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GrammarExplainSheet(
        sourceText: pair.sourceText,
        targetText: pair.targetText,
        userAnswer: userAnswer,
        targetLanguage: widget.targetLanguage,
      ),
    );
  }

  void _handleAnswer(SentencePair pair) {
    if (_selectedOption == null) return;

    final isCorrect = _selectedOption!.trim().toLowerCase() ==
        pair.targetText.trim().toLowerCase();

    final feedback = ref.read(feedbackServiceProvider);

    setState(() {
      _hasSubmitted = true;
    });

    if (isCorrect) {
      feedback.playCorrectFeedback();
      ref.read(srsLessonControllerProvider.notifier).recordAnswer(
            sentencePair: pair,
            grade: 5, // Perfect score in SM-2
          );
    } else {
      feedback.playWrongFeedback();
      if (_hearts > 0) {
        setState(() => _hearts--);
      }
      ref.read(srsLessonControllerProvider.notifier).recordAnswer(
            sentencePair: pair,
            grade: 0, // Fail score in SM-2
          );
    }
  }

  void _nextExercise(int totalPairs) {
    if (_currentIndex + 1 >= totalPairs) {
      // Finish Lesson
      if (!_hasCompletedLesson) {
        _hasCompletedLesson = true;
        ref.read(srsLessonControllerProvider.notifier).finishLesson(
              topic: widget.lessonId,
              xpEarned: 25,
            );
      }
      setState(() => _currentIndex++);
    } else {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _hasSubmitted = false;
        _currentOptions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deckAsync = ref.watch(srsLessonControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSrsReview ? 'SRS Daily Review' : widget.lessonId,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 22),
              const SizedBox(width: 4),
              Text(
                '$_hearts',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: deckAsync.when(
          loading: () => _buildBouncingLoadingState(theme),
          error: (err, stack) => _buildErrorState(context, theme, err),
          data: (deck) {
            final pairs = deck.sentencePairs;

            if (pairs.isEmpty) {
              return _buildEmptyDeckState(context, theme);
            }

            if (_hearts <= 0) {
              return _buildGameOverState(context, theme);
            }

            if (_currentIndex >= pairs.length) {
              return _buildCompletionState(context, theme);
            }

            final currentPair = pairs[_currentIndex];
            _generateOptions(currentPair, pairs);

            final progress = (_currentIndex + 1) / pairs.length;
            final isCorrect = _hasSubmitted &&
                _selectedOption?.trim().toLowerCase() ==
                    currentPair.targetText.trim().toLowerCase();

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedProgressBar(
                    value: progress,
                    height: 12,
                    progressColor: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Item ${_currentIndex + 1} of ${pairs.length}',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Prompt Card
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  currentPair.difficultyLevel,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 26,
                                ),
                                tooltip: 'Listen Pronunciation',
                                onPressed: () => _speakText(currentPair.targetText),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Translate into ${widget.targetLanguage}:',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentPair.sourceText,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (currentPair.grammarNotes != null &&
                              currentPair.grammarNotes!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Hint: ${currentPair.grammarNotes}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.tertiary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Multiple Choice Options
                  Expanded(
                    child: ListView.separated(
                      itemCount: _currentOptions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, idx) {
                        final option = _currentOptions[idx];
                        final isSelected = _selectedOption == option;
                        final isThisCorrect =
                            option.trim().toLowerCase() == currentPair.targetText.trim().toLowerCase();

                        Color borderClr = theme.colorScheme.outlineVariant;
                        Color bgClr = theme.colorScheme.surface;

                        if (_hasSubmitted) {
                          if (isThisCorrect) {
                            borderClr = Colors.green;
                            bgClr = Colors.green.withValues(alpha: 0.1);
                          } else if (isSelected && !isThisCorrect) {
                            borderClr = Colors.red;
                            bgClr = Colors.red.withValues(alpha: 0.1);
                          }
                        } else if (isSelected) {
                          borderClr = theme.colorScheme.primary;
                          bgClr = theme.colorScheme.primaryContainer.withValues(alpha: 0.3);
                        }

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: InkWell(
                            onTap: _hasSubmitted
                                ? null
                                : () {
                                    setState(() => _selectedOption = option);
                                  },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: bgClr,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: borderClr, width: isSelected ? 2 : 1),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight:
                                            isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  if (_hasSubmitted && isThisCorrect)
                                    const Icon(Icons.check_circle, color: Colors.green)
                                  else if (_hasSubmitted && isSelected && !isThisCorrect)
                                    const Icon(Icons.cancel, color: Colors.red),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // On-demand AI "Why is this wrong?" button when submitted & wrong
                  if (_hasSubmitted && !isCorrect) ...[
                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () => _openGrammarExplainSheet(
                          currentPair,
                          _selectedOption ?? '',
                        ),
                        icon: const Icon(Icons.auto_awesome, color: Colors.purple),
                        label: const Text(
                          'Why is this wrong?',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Check / Next Action Button
                  ElevatedButton(
                    onPressed: _selectedOption == null
                        ? null
                        : () {
                            if (_hasSubmitted) {
                              _nextExercise(pairs.length);
                            } else {
                              _handleAnswer(currentPair);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      _hasSubmitted ? 'Continue' : 'Check Answer',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );

          },
        ),
      ),
    );
  }

  Widget _buildBouncingLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Loading SRS Decks...',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDeckState(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sentiment_satisfied_alt, size: 64, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'No Due SRS Reviews!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are all caught up on your spaced repetition reviews for today.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Back to Lessons'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ThemeData theme, Object err) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Failed to load lesson deck',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$err',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOverState(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.heart_broken_rounded, size: 72, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Out of Hearts!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Take a short break to review your mistakes and restore your energy.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionState(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.military_tech_rounded, size: 88, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Lesson Completed!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '+25 XP Earned • SRS Intervals Updated!',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.amber.shade800,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.check),
              label: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
