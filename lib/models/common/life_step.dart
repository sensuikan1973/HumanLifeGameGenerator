import 'package:flutter/foundation.dart';

import 'life_event.dart';
import 'life_event_params/life_event_params.dart';

class LifeStepModel {
  LifeStepModel({
    @required this.id,
    @required this.lifeEvent,
    @required this.right,
    @required this.left,
    @required this.up,
    @required this.down,
  });

  final int id;
  final LifeEventModel lifeEvent;

  LifeStepModel up;
  LifeStepModel down;
  LifeStepModel right;
  LifeStepModel left;

  bool get isStart => lifeEvent.type == LifeEventType.start;
  bool get isGoal => lifeEvent.type == LifeEventType.goal;
  bool get isBranch => lifeEvent.isBranch;

  DestinationWithMovedStepCount getNextUntilForceStopStep(int num) {
    var current = this;
    var count = 0;
    while (current != null && count < num) {
      // TODO: 実装
      // if (current == 強制ストップ) return xxx;

      final next = [
        current.up,
        current.down,
        current.right,
        current.left,
      ].firstWhere((el) => el != null, orElse: () => null);
      if (next == null) break;
      current = next;
      count++;
    }
    return DestinationWithMovedStepCount(wantToMoveCount: num, movedCount: count, destination: current);
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is LifeStepModel && other.id == id;
}

class DestinationWithMovedStepCount {
  const DestinationWithMovedStepCount({
    this.wantToMoveCount,
    this.movedCount,
    this.destination,
  });

  /// 進もうとした数
  final int wantToMoveCount;

  /// 実際に進んだ数
  final int movedCount;

  /// 進んだ結果到着した lifeStep
  final LifeStepModel destination;
}
