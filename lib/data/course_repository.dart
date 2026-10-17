import 'models/lesson.dart';
import 'sample_course.dart';

abstract interface class CourseRepository {
  List<Lesson> get lessons;
  Lesson? byId(String id);
}

class InMemoryCourseRepository implements CourseRepository {
  InMemoryCourseRepository(List<Lesson> lessons)
      : lessons = List.unmodifiable(lessons);

  factory InMemoryCourseRepository.sample() =>
      InMemoryCourseRepository(buildSampleLessons());

  @override
  final List<Lesson> lessons;

  @override
  Lesson? byId(String id) {
    for (final l in lessons) {
      if (l.id == id) return l;
    }
    return null;
  }
}
