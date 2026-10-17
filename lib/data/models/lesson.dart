import 'conversation_line.dart';

class Lesson {
  const Lesson({
    required this.id,
    required this.number,
    required this.title,
    required this.topic,
    required this.lines,
  });

  final String id;
  final int number;
  final String title;
  final String topic;
  final List<ConversationLine> lines;

  int get durationMs => lines.fold(0, (sum, l) => sum + l.durationMs);

  int lineStartMs(int index) {
    var start = 0;
    for (var i = 0; i < index && i < lines.length; i++) {
      start += lines[i].durationMs;
    }
    return start;
  }

  /// Maps a global position to (line, word). Clamps to the last line at/after the end.
  ({int line, int word}) locate(int positionMs) {
    if (lines.isEmpty || positionMs < 0) return (line: -1, word: -1);
    var start = 0;
    for (var i = 0; i < lines.length; i++) {
      final end = start + lines[i].durationMs;
      if (positionMs < end || i == lines.length - 1) {
        return (line: i, word: lines[i].wordIndexAt(positionMs - start));
      }
      start = end;
    }
    return (line: -1, word: -1);
  }
}
