import 'package:flutter_test/flutter_test.dart';
import 'package:vision2_app/playback/simulated_engine.dart';

void main() {
  late SimulatedPlaybackEngine e;
  setUp(() {
    e = SimulatedPlaybackEngine(autoTick: false)..load(1000);
  });
  tearDown(() => e.dispose());

  test('does not advance until play', () {
    e.tick(100);
    expect(e.positionMs, 0);
  });

  test('advances and respects speed', () {
    e.play();
    e.tick(200);
    expect(e.positionMs, 200);
    e.setSpeed(1.25);
    e.tick(200);
    expect(e.positionMs, 450);
  });

  test('pause keeps position', () {
    e.play();
    e.tick(300);
    e.pause();
    e.tick(300);
    expect(e.positionMs, 300);
    expect(e.isPlaying, isFalse);
  });

  test('completes once and replays from start', () {
    var completed = 0;
    e.completedStream.listen((_) => completed++);
    e.play();
    e.tick(5000);
    expect(e.positionMs, 1000);
    expect(completed, 1);
    expect(e.isPlaying, isFalse);
    e.play();
    expect(e.positionMs, 0);
    expect(e.isPlaying, isTrue);
  });

  test('seek clamps', () {
    e.seek(5000);
    expect(e.positionMs, 1000);
    e.seek(-5);
    expect(e.positionMs, 0);
  });
}
