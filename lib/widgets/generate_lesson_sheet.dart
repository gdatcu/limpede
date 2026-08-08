import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/lesson_provider.dart';

class GenerateLessonSheet extends ConsumerStatefulWidget {
  const GenerateLessonSheet({super.key});

  @override
  ConsumerState<GenerateLessonSheet> createState() => _GenerateLessonSheetState();
}

class _GenerateLessonSheetState extends ConsumerState<GenerateLessonSheet> {
  final _topicController = TextEditingController();
  String _targetLanguage = 'Spanish';

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Generate Custom AI Lesson',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
              hintText: 'e.g., Ordering coffee in Madrid, Tech interview terms',
              labelText: 'Topic',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              prefixIcon: const Icon(Icons.lightbulb_outline),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _targetLanguage,
            decoration: InputDecoration(
              labelText: 'Target Language',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              prefixIcon: const Icon(Icons.translate),
            ),
            items: const [
              DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
              DropdownMenuItem(value: 'French', child: Text('French')),
              DropdownMenuItem(value: 'German', child: Text('German')),
              DropdownMenuItem(value: 'Japanese', child: Text('Japanese')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() => _targetLanguage = val);
              }
            },
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              final topic = _topicController.text.trim().isEmpty
                  ? 'General Conversation'
                  : _topicController.text.trim();
              Navigator.pop(context);

              ref.read(lessonControllerProvider.notifier).generateLesson(
                    topic: topic,
                    targetLanguage: _targetLanguage,
                    isCustomAiTopic: true,
                  );

              context.push('/lesson/$topic?language=$_targetLanguage&isAi=true');
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            icon: const Icon(Icons.play_arrow),
            label: const Text(
              'Start Learning',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
