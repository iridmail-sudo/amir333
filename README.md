# Vision 2 App v1.0.0+1

## Run
    flutter pub get
    flutter analyze
    flutter test
    flutter run

## Structure
- lib/core: version, theme, formatting
- lib/data: models (WordTiming, ConversationLine, Lesson), repository, sample content
- lib/playback: PlaybackEngine interface, SimulatedPlaybackEngine, PlayerController
- lib/features: home (dashboard), player (lesson screen)
- test: unit + controller + version + smoke tests

## Real audio (next step)
Implement `PlaybackEngine` with `audioplayers` (positionStream -> positionStream,
onPlayerComplete -> completedStream), then pass it via `Vision2App(engineFactory: ...)`.
Replace estimated timings in `sample_course.dart` with measured per-word ms values.

## Versioning
Bump `version:` in pubspec.yaml and `AppVersion` in lib/core/app_version.dart together;
test/version_test.dart fails if they differ. Record changes in CHANGELOG.md.

## Known placeholders
Lesson content, Persian translations and word timings are sample data, not the book.
Progress persistence is not implemented yet.

## Build APK
Locally: `flutter create --platforms=android --project-name vision2_app .` once, then `flutter build apk --release`.
Output: build/app/outputs/flutter-apk/app-release.apk
Or push to GitHub and run the "Build APK" workflow; download the `vision2-apk` artifact.
