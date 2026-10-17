import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_version.dart';
import '../../data/course_repository.dart';
import 'lesson_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = context.read<CourseRepository>().lessons;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppVersion.name)),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: lessons.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Welcome, Amir!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold, color: scheme.primary),
              ),
            );
          }
          return LessonCard(lesson: lessons[index - 1]);
        },
      ),
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            '${AppVersion.name} v${AppVersion.full}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
