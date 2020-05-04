import 'package:flutter/material.dart';

class Human extends StatelessWidget {
  const Human();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 20,
        height: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
