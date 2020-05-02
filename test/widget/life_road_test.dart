import 'package:HumanLifeGame/screens/play_room/life_road.dart';
import 'package:HumanLifeGame/screens/play_room/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  group('LifeRoad', () {
    testWidgets('show LifeStep', (tester) async {
      await tester.pumpWidget(testableApp(locale: locale, home: LifeRoad()));
      await tester.pump();
      expect(find.byType(LifeStep), findsOneWidget);
    });
  });
}