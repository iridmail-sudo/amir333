# Changelog

## 1.0.0+1
- Modular architecture: core / data / playback / features.
- PlaybackEngine abstraction (simulated engine now, real audio later).
- Word highlight driven by playback position and per-word timings.
- Correct Pause (keeps position and highlighted word), Replay, prev/next sentence, seek, speed 0.75/1/1.25.
- Persian translation toggle, auto-scroll to active sentence.
- Light/dark Material 3 theme, 48dp+ touch targets, tooltips for TalkBack.
- Unit, controller, version and widget smoke tests.
- Fixed: ChangeNotifierProvider `builder` signature bug from the previous code.
