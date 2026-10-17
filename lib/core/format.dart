/// Formats milliseconds as mm:ss.
String formatMs(int ms) {
  final totalSeconds = (ms < 0 ? 0 : ms) ~/ 1000;
  final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
  final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
