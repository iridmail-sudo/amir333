import 'models/conversation_line.dart';
import 'models/lesson.dart';
import 'models/word_timing.dart';

/// PLACEHOLDER content and ESTIMATED timings (proportional to word length).
/// Replace with real book content and measured audio timings.
List<WordTiming> _estimate(String text) {
  final out = <WordTiming>[];
  var t = 0;
  for (final w in text.split(' ')) {
    final d = 150 + w.length * 55;
    out.add(WordTiming(word: w, startMs: t, endMs: t + d));
    t += d;
  }
  return out;
}

ConversationLine _line(String id, String speaker, String en, String fa) =>
    ConversationLine(
      id: id,
      speakerId: speaker,
      persianTranslation: fa,
      timings: _estimate(en),
    );

List<Lesson> buildSampleLessons() => [
      Lesson(
        id: 'l1',
        number: 1,
        title: 'Lesson 1',
        topic: 'Conversations Foundation',
        lines: [
          _line('l1-1', 'A', 'Hello, welcome to the first lesson.',
              'سلام، به اولین درس خوش آمدید.'),
          _line('l1-2', 'B', 'Thank you. I am ready to start the Vision Two book.',
              'ممنونم. آماده‌ام کتاب ویژن ۲ را شروع کنم.'),
        ],
      ),
      Lesson(
        id: 'l2',
        number: 2,
        title: 'Lesson 2',
        topic: 'Past continuous tense',
        lines: [
          _line('l2-1', 'A', 'In this lesson we will study the past continuous tense.',
              'در این درس زمان گذشته استمراری را یاد می‌گیریم.'),
          _line('l2-2', 'B', 'I was reading a book while she was cooking.',
              'من کتاب می‌خواندم در حالی که او غذا می‌پخت.'),
        ],
      ),
    ];
