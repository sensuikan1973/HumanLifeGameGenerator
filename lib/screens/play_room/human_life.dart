import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:flutter/material.dart';

class PlayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 500,
          height: 400,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: LifeRoad(),
          ),
        ),
      );
}