import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/mocks.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);

  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    // Desktopの標準サイズ 1440x1024に設定
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });

  testWidgets('show some widgets', (tester) async {
    await tester.pumpWidget(
      Provider<Dice>(create: (context) => const Dice(), child: testableApp(home: const PlayRoom())),
    );
    await tester.pump();
    expect(find.byType(PlayerAction), findsOneWidget);
    expect(find.byType(DiceResult), findsOneWidget);
    expect(find.byType(LifeStages), findsOneWidget);
    expect(find.byType(Announcement), findsOneWidget);
    expect(find.byType(PlayView), findsOneWidget);
  });

  testWidgets('random value(1 <= value <= 6) should be displayed when dice is rolled', (tester) async {
    final dice = MockDice();
    when(dice.roll()).thenReturn(5);
    await tester.pumpWidget(
      Provider<Dice>(create: (context) => dice, child: testableApp(home: const PlayRoom())),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
    await tester.pump();
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('show Announcement message when dice is rolled', (tester) async {
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    await tester.pumpWidget(
      Provider<Dice>(create: (context) => dice, child: testableApp(home: const PlayRoom())),
    );
    await tester.pump();

    // FIXME: humans が内部で仮定義されているので、human name などはあくまで仮のテストに過ぎない
    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement('human_1_name', roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement('human_2_name', roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement('human_1_name', roll)), findsOneWidget);
  });

  testWidgets('show user name in human life stages', (tester) async {
    await tester.pumpWidget(
      Provider<Dice>(create: (context) => const Dice(), child: testableApp(home: const PlayRoom())),
    );
    await tester.pump();
    // FIXME: humans が内部で仮定義されているので、human name などはあくまで仮のテストに過ぎない
    expect(find.text('human_1_name'), findsOneWidget);
    expect(find.text('human_2_name'), findsOneWidget);
  });

  testWidgets('show currentPlayerSelector Icon in human life stages', (tester) async {
    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.pumpWidget(
      Provider<Dice>(create: (context) => const Dice(), child: testableApp(home: const PlayRoom())),
    );
    await tester.pump();
    // FIXME: humans が内部で仮定義されているので、human name などはあくまで仮のテストに過ぎない
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Row &&
            widget.children ==
                [
                  SizedBox(
                    key: const Key('lifeStagesSizedBox'),
                    child: Icon(
                      Icons.chevron_right,
                      key: const Key('lifeStagesCurrentPlayerSelector'),
                      color: Colors.pink,
                    ),
                  ),
                  //const Text('human_2_name'),
                ]),
        findsOneWidget);

    expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.chevron_right), findsOneWidget);
    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.chevron_right), findsOneWidget);
  });
}
