import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/models/lesson.dart';
import 'playback_engine.dart';

/// Holds all playback/learning state for one lesson. UI only reads this.
class PlayerController extends ChangeNotifier {
  PlayerController({required this.lesson, required PlaybackEngine engine})
      : _engine = engine {
    _engine.load(lesson.durationMs);
    _positionSub = _engine.positionStream.listen(_onPosition);
    _completedSub = _engine.completedStream.listen((_) {
      _isPlaying = false;
      notifyListeners();
    });
  }

  static const List<double> speeds = [0.75, 1.0, 1.25];

  final Lesson lesson;
  final PlaybackEngine _engine;
  late final StreamSubscription<int> _positionSub;
  late final StreamSubscription<void> _completedSub;

  int _positionMs = 0;
  bool _isPlaying = false;
  bool _showTranslation = true;
  double _speed = 1.0;
  ({int line, int word}) _cursor = (line: 0, word: 0);

  int get positionMs => _positionMs;
  int get durationMs => lesson.durationMs;
  bool get isPlaying => _isPlaying;
  bool get showTranslation => _showTranslation;
  double get speed => _speed;

  bool get _idle => _positionMs == 0 && !_isPlaying;

  /// -1 until playback has started, so nothing is highlighted on entry.
  int get activeLineIndex => _idle ? -1 : _cursor.line;
  int get activeWordIndex => _idle ? -1 : _cursor.word;

  void _onPosition(int ms) {
    _positionMs = ms;
    _cursor = lesson.locate(ms);
    notifyListeners();
  }

  void play() {
    _engine.play();
    _isPlaying = _engine.isPlaying;
    // After finishing, the engine restarts from 0 and emits a position event.
    notifyListeners();
  }

  /// Pause keeps position and the highlighted word.
  void pause() {
    _engine.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void togglePlay() => _isPlaying ? pause() : play();

  void replay() {
    _engine.seek(0);
    play();
  }

  void seek(int ms) => _engine.seek(ms);

  void nextLine() {
    final next = activeLineIndex < 0 ? 0 : activeLineIndex + 1;
    if (next >= lesson.lines.length) return;
    seek(lesson.lineStartMs(next));
  }

  void previousLine() {
    final current = activeLineIndex < 0 ? 0 : activeLineIndex;
    final intoLine = _positionMs - lesson.lineStartMs(current);
    final target = (intoLine > 1000 || current == 0) ? current : current - 1;
    seek(lesson.lineStartMs(target));
  }

  void setSpeed(double value) {
    _speed = value;
    _engine.setSpeed(value);
    notifyListeners();
  }

  void toggleTranslation() {
    _showTranslation = !_showTranslation;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionSub.cancel();
    _completedSub.cancel();
    _engine.dispose();
    super.dispose();
  }
}
