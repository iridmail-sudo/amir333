import 'dart:async';

import 'playback_engine.dart';

/// Clock-based engine for UI testing without audio files.
/// Not synchronized with any real audio.
class SimulatedPlaybackEngine implements PlaybackEngine {
  SimulatedPlaybackEngine({this.tickMs = 50, this.autoTick = true});

  final int tickMs;

  /// When false, time only advances through [tick] (used by tests).
  final bool autoTick;

  final StreamController<int> _position = StreamController<int>.broadcast(sync: true);
  final StreamController<void> _completed = StreamController<void>.broadcast(sync: true);
  Timer? _timer;
  int _duration = 0;
  int _pos = 0;
  double _speed = 1.0;
  bool _playing = false;

  @override
  Stream<int> get positionStream => _position.stream;
  @override
  Stream<void> get completedStream => _completed.stream;
  @override
  bool get isPlaying => _playing;
  @override
  int get positionMs => _pos;

  @override
  void load(int durationMs) {
    _stopTimer();
    _playing = false;
    _duration = durationMs;
    _pos = 0;
    _position.add(_pos);
  }

  @override
  void play() {
    if (_playing || _duration <= 0) return;
    if (_pos >= _duration) _pos = 0;
    _playing = true;
    if (autoTick) {
      _timer = Timer.periodic(Duration(milliseconds: tickMs), (_) => tick(tickMs));
    }
  }

  @override
  void pause() {
    _playing = false;
    _stopTimer();
  }

  @override
  void seek(int ms) {
    _pos = ms.clamp(0, _duration);
    _position.add(_pos);
  }

  @override
  void setSpeed(double speed) => _speed = speed;

  /// Advances the clock by [elapsedMs] of real time (scaled by speed).
  void tick(int elapsedMs) {
    if (!_playing) return;
    _pos = (_pos + (elapsedMs * _speed).round()).clamp(0, _duration);
    _position.add(_pos);
    if (_pos >= _duration) {
      _playing = false;
      _stopTimer();
      _completed.add(null);
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    _playing = false;
    _position.close();
    _completed.close();
  }
}
