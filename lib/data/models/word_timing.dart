/// Start/end (ms, relative to its sentence) of one spoken word.
class WordTiming {
  const WordTiming({
    required this.word,
    required this.startMs,
    required this.endMs,
  }) : assert(endMs > startMs, 'endMs must be greater than startMs');

  final String word;
  final int startMs;
  final int endMs;
}
