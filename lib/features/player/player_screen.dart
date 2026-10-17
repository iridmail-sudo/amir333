import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/lesson.dart';
import '../../playback/player_controller.dart';
import '../../playback/playback_engine.dart';
import 'controls_panel.dart';
import 'line_card.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerController>(
      create: (ctx) => PlayerController(
        lesson: lesson,
        engine: ctx.read<PlaybackEngineFactory>()(),
      ),
      child: const _PlayerView(),
    );
  }
}

class _PlayerView extends StatelessWidget {
  const _PlayerView();

  @override
  Widget build(BuildContext context) {
    final lesson = context.read<PlayerController>().lesson;
    final showTranslation =
        context.select<PlayerController, bool>((c) => c.showTranslation);

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        actions: [
          IconButton(
            tooltip: showTranslation
                ? 'Hide Persian translation'
                : 'Show Persian translation',
            isSelected: showTranslation,
            icon: const Icon(Icons.translate),
            onPressed: context.read<PlayerController>().toggleTranslation,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: lesson.lines.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => LineCard(index: i),
            ),
          ),
          const ControlsPanel(),
        ],
      ),
    );
  }
}
