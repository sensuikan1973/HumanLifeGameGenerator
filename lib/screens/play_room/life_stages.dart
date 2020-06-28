import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common/human.dart';
import '../../models/play_room/life_stage.dart';
import '../../models/play_room/play_room_notifier.dart';
import '../common/human.dart';

/// 各 Human たちの人生の進捗(= LifeStage)を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: _lifeStages(context),
      );

  Column _lifeStages(BuildContext context) {
    final lifeStages = context.select<PlayRoomNotifier, List<LifeStageModel>>((model) => model.value.lifeStages);
    final currentTurnHuman = context.select<PlayRoomNotifier, HumanModel>((model) => model.value.currentTurnHuman);
    final humanNames = <Widget>[
      for (final lifeStage in lifeStages)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: (currentTurnHuman == lifeStage.human) ? currentTurnHumanSelector() : null,
            ),
            Human(lifeStage.human),
            Text(lifeStage.human.name),
            const Text(', 💵: '), // FIXME: 仮テキスト
            Text(lifeStage.totalMoney.toString()),
          ],
        ),
    ];

    return Column(
      children: humanNames,
    );
  }

  Icon currentTurnHumanSelector() => const Icon(Icons.chevron_right, color: Colors.pink);
}
