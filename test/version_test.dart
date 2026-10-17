import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vision2_app/core/app_version.dart';

void main() {
  test('AppVersion matches pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final match = RegExp(r'^version:\s*(\S+)', multiLine: true).firstMatch(pubspec);
    expect(match, isNotNull);
    expect(match!.group(1), AppVersion.full);
  });
}
