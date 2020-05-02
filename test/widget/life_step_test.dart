import 'package:HumanLifeGame/i18n/i18n_delegate.dart';
import 'package:HumanLifeGame/screens/play_room/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LifeStep', () {
    testWidgets('show DecoratedBox', (tester) async {
      await tester.pumpWidget(_LifeStep());
      await tester.pump();
      expect(find.byType(DecoratedBox), findsOneWidget);
    });
  });
}

class _LifeStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Test App For LifeStep',
        localizationsDelegates: const [I18nDelegate()],
        supportedLocales: const [Locale('en', 'US')],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LifeStep(),
      );
}
