import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../playback/player_controller.dart';
import 'highlighted_text.dart';

class LineCard extends StatefulWidget {
  const LineCard({super.key, required this.index});

  final int index;

  @override
  State<LineCard> createState() => _LineCardState();
}

class _LineCardState extends State<LineCard> {
  bool _wasActive = false;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PlayerController>();
    final state = context.select<PlayerController,
        ({bool active, int word, bool translate})>(
      (c) => (
        active: c.activeLineIndex == widget.index,
        word: c.activeLineIndex == widget.index ? c.activeWordIndex : -1,
        translate: c.showTranslation,
      ),
    );

    // Keep the sentence being read in view.
    if (state.active && !_wasActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 250),
            alignment: 0.3,
          );
        }
      });
    }
    _wasActive = state.active;

    final line = controller.lesson.lines[widget.index];
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: state.active ? scheme.primary : scheme.outlineVariant,
          width: state.active ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => controller.seek(controller.lesson.lineStartMs(widget.index)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Speaker ${line.speakerId}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              HighlightedText(
                words: line.words,
                activeIndex: state.word,
                style: const TextStyle(fontSize: 24, height: 1.4),
              ),
              if (state.translate) ...[
                const SizedBox(height: 8),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      line.persianTranslation,
                      style: TextStyle(
                        fontSize: 17,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
