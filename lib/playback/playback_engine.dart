/// Abstraction over audio playback. Positions are in milliseconds on the
/// lesson timeline. Implement with `audioplayers` for real audio.
abstract interface class PlaybackEngine {
  Stream<int> get positionStream;
  Stream<void> get completedStream;
  bool get isPlaying;
  int get positionMs;

  void load(int durationMs);
  void play();
  void pause();
  void seek(int ms);
  void setSpeed(double speed);
  void dispose();
}

typedef PlaybackEngineFactory = PlaybackEngine Function();
