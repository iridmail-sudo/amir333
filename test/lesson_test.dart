import 'package:flutter_test/flutter_test.dart';
import 'package:vision2_app/data/sample_course.dart';

void main() {
  final lesson = buildSampleLessons().first;
  final first = lesson.lines.first;

  test('english text is derived from timings', () {
    expect(first.englishText, 'Hello, welcome to the first lesson.');
  });

  test('locate at 0 is line 0 word 0', () {
    expect(lesson.locate(0), (line: 0, word: 0));
  });

  test('word boundary moves to next word', () {
    final w1 = first.timings[1].startMs;
    expect(lesson.locate(w1 - 1).word, 0);
    expect(lesson.locate(w1).word, 1);
  });

  test('gap after sentence keeps last word', () {
    final gapMs = first.timings.last.endMs + 10;
    expect(lesson.locate(gapMs), (line: 0, word: first.timings.length - 1));
  });

  test('second line starts exactly at lineStartMs', () {
    expect(lesson.locate(lesson.lineStartMs(1)), (line: 1, word: 0));
  });

  test('end and out-of-range clamp', () {
    expect(lesson.locate(lesson.durationMs).line, lesson.lines.length - 1);
    expect(lesson.locate(-5), (line: -1, word: -1));
  });
}
