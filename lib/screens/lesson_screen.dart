import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/srs_models.dart';
import '../providers/course_provider.dart';
import '../providers/feedback_provider.dart';
import '../providers/lesson_provider.dart';
import '../providers/srs_lesson_provider.dart';
import '../utils/language_utils.dart';
import '../utils/localized_strings.dart';
import '../utils/topic_translator.dart';
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

  void _generateOptions({
    required SentencePair currentPair,
    required List<SentencePair> deck,
    required bool isReverseMode,
    required String nativeLanguage,
    required String targetLanguage,
  }) {
    if (_currentOptions.isNotEmpty) return;

    final String correctAnswer = isReverseMode ? currentPair.sourceText : currentPair.targetText;
    final Set<String> optionsSet = {correctAnswer};

    for (var p in deck) {
      final text = isReverseMode ? p.sourceText : p.targetText;
      if (text != correctAnswer) {
        optionsSet.add(text);
      }
      if (optionsSet.length >= 4) break;
    }

    final fallbacks = isReverseMode
        ? ['Hello, how are you?', 'Good morning!', 'Thank you very much!', 'Nice to meet you', 'See you tomorrow!']
        : LanguageUtils.getFallbackDistractors(targetLanguage);

    for (var f in fallbacks) {
      if (optionsSet.length >= 4) break;
      if (f != correctAnswer) optionsSet.add(f);
    }

    final list = optionsSet.toList();
    list.shuffle(math.Random(currentPair.id.hashCode));
    _currentOptions = list;
  }

  void _speakText(String text, String language) {
    final tts = ref.read(ttsServiceProvider);
    tts.speak(text: text, targetLanguage: language);
  }

  void _openGrammarExplainSheet(SentencePair pair, String userAnswer, String targetLanguage) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GrammarExplainSheet(
        sourceText: pair.sourceText,
        targetText: pair.targetText,
        userAnswer: userAnswer,
        targetLanguage: targetLanguage,
      ),
    );
  }

  void _handleAnswer(SentencePair pair, bool isReverseMode) {
    if (_selectedOption == null) return;

    final String correctAnswer = isReverseMode ? pair.sourceText : pair.targetText;
    final isCorrect = _selectedOption!.trim().toLowerCase() == correctAnswer.trim().toLowerCase();

    final feedback = ref.read(feedbackServiceProvider);

    setState(() {
      _hasSubmitted = true;
    });

    if (isCorrect) {
      feedback.playCorrectFeedback();
      ref.read(srsLessonControllerProvider.notifier).recordAnswer(
            sentencePair: pair,
            grade: 5,
          );
    } else {
      feedback.playWrongFeedback();
      if (_hearts > 0) {
        setState(() => _hearts--);
      }
      ref.read(srsLessonControllerProvider.notifier).recordAnswer(
            sentencePair: pair,
            grade: 0,
          );
    }
  }

  void _nextChallenge(int totalItems) {
    if (_currentIndex + 1 >= totalItems) {
      if (!_hasCompletedLesson) {
        _hasCompletedLesson = true;
        ref.read(srsLessonControllerProvider.notifier).finishLesson(
              topic: widget.lessonId,
            );
      }
    }

    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _hasSubmitted = false;
      _currentOptions = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deckAsync = ref.watch(srsLessonControllerProvider);
    final courseState = ref.watch(courseStateNotifierProvider);
    final isReverseMode = courseState.isReverseMode;
    final nativeLang = courseState.nativeLanguage;
    final targetLang = courseState.targetLanguage;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TopicTranslator.translateCategory(widget.lessonId, LanguageUtils.normalizeLanguageCode(nativeLang)),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 22),
              const SizedBox(width: 4),
              Text(
                '$_hearts',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
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
            _generateOptions(
              currentPair: currentPair,
              deck: pairs,
              isReverseMode: isReverseMode,
              nativeLanguage: nativeLang,
              targetLanguage: targetLang,
            );

            final progress = (_currentIndex + 1) / pairs.length;
            final String correctAnswer = isReverseMode ? currentPair.sourceText : currentPair.targetText;
            final String promptText = isReverseMode ? currentPair.targetText : currentPair.sourceText;
            final String promptSpeakerLang = isReverseMode ? nativeLang : targetLang;

            final isCorrect = _hasSubmitted &&
                _selectedOption?.trim().toLowerCase() == correctAnswer.trim().toLowerCase();

            final headerText = LocalizedStrings.getTranslateInto(
              nativeLanguage: nativeLang,
              targetLanguage: targetLang,
            );

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
                                onPressed: () => _speakText(promptText, promptSpeakerLang),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            headerText,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            promptText,
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
                            option.trim().toLowerCase() == correctAnswer.trim().toLowerCase();

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

                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            side: BorderSide(color: borderClr, width: 2),
                            backgroundColor: bgClr,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: _hasSubmitted
                              ? null
                              : () => setState(() => _selectedOption = option),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              option,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Feedback Banner & Action Buttons
                  if (_hasSubmitted) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.red.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            color: isCorrect ? Colors.green : Colors.red,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isCorrect
                                      ? LocalizedStrings.getExcellent(nativeLang)
                                      : LocalizedStrings.getIncorrect(nativeLang),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),
                                if (!isCorrect) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Correct answer: $correctAnswer',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (!isCorrect)
                            IconButton(
                              icon: const Icon(Icons.help_outline_rounded),
                              tooltip: 'Explain My Mistake',
                              onPressed: () => _openGrammarExplainSheet(
                                currentPair,
                                _selectedOption ?? '',
                                targetLang,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _selectedOption == null
                        ? null
                        : () {
                            if (!_hasSubmitted) {
                              _handleAnswer(currentPair, isReverseMode);
                            } else {
                              _nextChallenge(pairs.length);
                            }
                          },
                    child: Text(
                      !_hasSubmitted
                          ? LocalizedStrings.getCheckAnswer(nativeLang)
                          : LocalizedStrings.getContinue(nativeLang),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Preparing your lesson microlesson...',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ThemeData theme, Object err) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Unable to load lesson.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              err.toString(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDeckState(BuildContext context, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 48),
            const SizedBox(height: 16),
            Text(
              'No items available for this topic.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Back to Home'),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.heart_broken_rounded, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Out of Hearts!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete a Daily Review or try again tomorrow to refill hearts.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Return to Skill Tree'),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars_rounded, size: 80, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Lesson Completed!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You earned +25 XP! Great job mastering this microlesson.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () => context.pop(),
              child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
