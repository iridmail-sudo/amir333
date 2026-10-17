import 'word_timing.dart';

/// One sentence spoken by one speaker, with Persian translation and word timings.
class ConversationLine {
  const ConversationLine({
    required this.id,
    required this.speakerId,
    required this.persianTranslation,
    required this.timings,
    this.trailingPauseMs = 400,
  });

  final String id;
  final String speakerId;
  final String persianTranslation;
  final List<WordTiming> timings;

  /// Silence after the sentence, before the next one starts.
  final int trailingPauseMs;

  /// English text is derived from timings so text and timing can never diverge.
  String get englishText => timings.map((t) => t.word).join(' ');

  List<String> get words => timings.map((t) => t.word).toList(growable: false);

  int get durationMs =>
      (timings.isEmpty ? 0 : timings.last.endMs) + trailingPauseMs;

  /// Index of the word being spoken at [localMs] (relative to line start).
  /// Stays on the last started word during gaps; -1 before the first word.
  int wordIndexAt(int localMs) {
    var index = -1;
    for (var i = 0; i < timings.length; i++) {
      if (timings[i].startMs <= localMs) {
        index = i;
      } else {
        break;
      }
    }
    return index;
  }
}
