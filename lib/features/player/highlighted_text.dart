import 'package:flutter/material.dart';

import '../../core/theme.dart';

/// English sentence with the active word marked by color, background AND underline
/// (no font-weight change, so the text never reflows while playing).
class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.words,
    required this.activeIndex,
    this.style,
  });

  final List<String> words;
  final int activeIndex;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final fg = HighlightColors.foreground(brightness);
    final bg = HighlightColors.background(brightness);

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text.rich(
        TextSpan(
          style: style,
          children: [
            for (var i = 0; i < words.length; i++) ...[
              TextSpan(
                text: words[i],
                style: i == activeIndex
                    ? TextStyle(
                        color: fg,
                        backgroundColor: bg,
                        decoration: TextDecoration.underline,
                        decorationColor: fg,
                      )
                    : null,
              ),
              if (i < words.length - 1) const TextSpan(text: ' '),
            ],
          ],
        ),
      ),
    );
  }
}
