import 'package:flutter/material.dart';

import '../../core/format.dart';
import '../../data/models/lesson.dart';
import '../player/player_screen.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => PlayerScreen(lesson: lesson)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
                child: Text('${lesson.number}'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(lesson.topic),
                    Text(
                      '${lesson.lines.length} sentences · ${formatMs(lesson.durationMs)}',
                      style: text.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(Icons.play_circle_fill, size: 40, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
