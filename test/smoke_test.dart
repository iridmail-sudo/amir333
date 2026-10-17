import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vision2_app/app.dart';
import 'package:vision2_app/features/player/controls_panel.dart';
import 'package:vision2_app/features/player/player_screen.dart';
import 'package:vision2_app/playback/player_controller.dart';

void main() {
  testWidgets('smoke: home -> lesson -> play -> highlight -> pause', (tester) async {
    await tester.pumpWidget(const Vision2App());

    expect(find.text('Vision 2'), findsOneWidget);
    expect(find.text('Lesson 1'), findsOneWidget);
    expect(find.text('Lesson 2'), findsOneWidget);

    await tester.tap(find.text('Lesson 1'));
    await tester.pumpAndSettle();
    expect(find.byType(PlayerScreen), findsOneWidget);

    await tester.tap(find.byTooltip('Play'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1000));

    final c = tester.element(find.byType(ControlsPanel)).read<PlayerController>();
    expect(c.isPlaying, isTrue);
    expect(c.positionMs, greaterThan(0));
    expect(c.activeWordIndex, greaterThanOrEqualTo(0));

    await tester.tap(find.byTooltip('Pause'));
    await tester.pump();
    final frozen = c.positionMs;
    await tester.pump(const Duration(seconds: 1));
    expect(c.positionMs, frozen);
    expect(c.activeWordIndex, greaterThanOrEqualTo(0));

    // Dispose the tree so no timers remain pending.
    await tester.pumpWidget(const SizedBox());
  });
}
