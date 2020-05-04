import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/screens/play_room/human.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model);
  final LifeEventModel model;
  @override
  Widget build(BuildContext context) => Align(
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: 1050 / 7,
              height: 700 / 7,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: model.type == LifeEventType.nothing ? Colors.amber[50] : Colors.cyan[50],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 1050 / 7,
              height: 700 / 7,
              child: Human(
                Alignment.topRight,
                model.type == LifeEventType.nothing ? Colors.white : Colors.red[50],
              ),
            ),
            SizedBox(
              width: 1050 / 7,
              height: 700 / 7,
              child: Human(
                Alignment.bottomRight,
                model.type == LifeEventType.nothing ? Colors.white : Colors.green[50],
              ),
            ),
            SizedBox(
              width: 1050 / 7,
              height: 700 / 7,
              child: Human(
                Alignment.topLeft,
                model.type == LifeEventType.nothing ? Colors.white : Colors.yellow[50],
              ),
            ),
            SizedBox(
              width: 1050 / 7,
              height: 700 / 7,
              child: Human(
                Alignment.bottomLeft,
                model.type == LifeEventType.nothing ? Colors.white : Colors.blue[50],
              ),
            ),
            Text(
              '\n宝くじが当たりました。\n\n出目X5000貰える。',
              style: TextStyle(
                fontSize: 12,
                color: model.type == LifeEventType.nothing ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      );
}
