import 'package:flutter_test/flutter_test.dart';
import 'package:vision2_app/data/sample_course.dart';
import 'package:vision2_app/playback/player_controller.dart';
import 'package:vision2_app/playback/simulated_engine.dart';

void main() {
  late SimulatedPlaybackEngine engine;
  late PlayerController c;

  setUp(() {
    engine = SimulatedPlaybackEngine(autoTick: false);
    c = PlayerController(lesson: buildSampleLessons().first, engine: engine);
  });
  tearDown(() => c.dispose());

  test('nothing highlighted before playback', () {
    expect(c.activeLineIndex, -1);
    expect(c.activeWordIndex, -1);
  });

  test('play highlights a word', () {
    c.play();
    engine.tick(100);
    expect(c.isPlaying, isTrue);
    expect(c.activeLineIndex, 0);
    expect(c.activeWordIndex, 0);
  });

  test('pause keeps highlighted word and position', () {
    c.play();
    engine.tick(700);
    final word = c.activeWordIndex;
    final pos = c.positionMs;
    c.pause();
    engine.tick(500);
    expect(c.isPlaying, isFalse);
    expect(c.activeWordIndex, word);
    expect(c.positionMs, pos);
  });

  test('resume continues from paused position', () {
    c.play();
    engine.tick(700);
    c.pause();
    c.play();
    engine.tick(100);
    expect(c.positionMs, 800);
  });

  test('replay restarts from zero and plays', () {
    c.play();
    engine.tick(900);
    c.replay();
    expect(c.positionMs, 0);
    expect(c.isPlaying, isTrue);
  });

  test('next and previous sentence', () {
    c.play();
    engine.tick(100);
    c.nextLine();
    expect(c.activeLineIndex, 1);
    expect(c.positionMs, c.lesson.lineStartMs(1));
    c.previousLine(); // at line start -> go to previous line
    expect(c.activeLineIndex, 0);
  });

  test('finishing stops playing', () {
    c.play();
    engine.tick(c.durationMs + 1);
    expect(c.isPlaying, isFalse);
    expect(c.positionMs, c.durationMs);
  });

  test('speed and translation toggles', () {
    c.setSpeed(0.75);
    expect(c.speed, 0.75);
    c.toggleTranslation();
    expect(c.showTranslation, isFalse);
  });
}
