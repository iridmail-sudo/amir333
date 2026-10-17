import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/format.dart';
import '../../playback/player_controller.dart';

class ControlsPanel extends StatelessWidget {
  const ControlsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<PlayerController>();
    final scheme = Theme.of(context).colorScheme;
    final duration = c.durationMs;

    return Material(
      color: scheme.surfaceContainer,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: c.positionMs.clamp(0, duration).toDouble(),
                max: duration.toDouble(),
                label: formatMs(c.positionMs),
                semanticFormatterCallback: (v) => formatMs(v.round()),
                onChanged: (v) => c.seek(v.round()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatMs(c.positionMs)),
                  Text(formatMs(duration)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: 'Previous sentence',
                    iconSize: 32,
                    onPressed: c.previousLine,
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    tooltip: 'Restart lesson',
                    iconSize: 32,
                    onPressed: c.replay,
                    icon: const Icon(Icons.replay),
                  ),
                  IconButton.filled(
                    tooltip: c.isPlaying ? 'Pause' : 'Play',
                    iconSize: 36,
                    constraints: const BoxConstraints.tightFor(width: 64, height: 64),
                    onPressed: c.togglePlay,
                    icon: Icon(c.isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                  IconButton(
                    tooltip: 'Next sentence',
                    iconSize: 32,
                    onPressed: c.nextLine,
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SegmentedButton<double>(
                showSelectedIcon: false,
                segments: [
                  for (final s in PlayerController.speeds)
                    ButtonSegment<double>(value: s, label: Text('$s×')),
                ],
                selected: {c.speed},
                onSelectionChanged: (v) => c.setSpeed(v.first),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
