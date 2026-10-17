/// Single source of truth for the app version.
/// Must match `version:` in pubspec.yaml (enforced by test/version_test.dart).
abstract final class AppVersion {
  static const String name = 'Vision 2';
  static const String version = '1.0.0';
  static const int build = 1;
  static const String full = '$version+$build';
}
