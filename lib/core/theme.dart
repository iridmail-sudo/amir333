import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color seed = Color(0xFF172554);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: brightness),
      scaffoldBackgroundColor: isLight ? const Color(0xFFF8FAFC) : null,
    );
  }
}

/// Colors for the active word. Highlight never relies on color alone
/// (the widget also adds an underline).
abstract final class HighlightColors {
  static Color background(Brightness b) =>
      b == Brightness.light ? const Color(0xFFFEF3C7) : const Color(0xFF713F12);
  static Color foreground(Brightness b) =>
      b == Brightness.light ? const Color(0xFF172554) : const Color(0xFFFEF3C7);
}
