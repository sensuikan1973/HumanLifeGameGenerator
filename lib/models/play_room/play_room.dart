import 'package:flutter/foundation.dart';

import '../../api/dice.dart';
import '../../i18n/i18n.dart';
import '../../services/life_event_service.dart';
import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_step.dart';
import 'life_event_record.dart';
import 'life_stage.dart';
import 'play_room_state.dart';

class PlayRoomNotifier extends ValueNotifier<PlayRoomState> {
  PlayRoomNotifier(
    this._i18n,
    this._dice,
    HumanLifeModel humanLife,
    List<HumanModel> humans,
  ) : super(PlayRoomState(
          humanLife,
          humans..sort((a, b) => a.order.compareTo(b.order)),
        )) {
    // 参加者全員の位置を Start に
    for (final human in value.orderedHumans) {
      final lifeStage = LifeStageModel(human)..lifeStepModel = value.humanLife.lifeRoad.start;
      value.lifeStages.add(lifeStage);
    }
    // 一番手の set
    value.currentTurnHuman = value.orderedHumans.first;
  }

  final I18n _i18n;
  final Dice _dice;
  final _lifeEventService = const LifeEventService();

  int get _currentPlayerLifeStageIndex =>
      value.lifeStages.indexWhere((lifeStage) => lifeStage.human == value.currentTurnHuman);
  LifeStageModel get _currentPlayerLifeStage => value.lifeStages[_currentPlayerLifeStageIndex];
  LifeStepModel get currentPlayerLifeStep => _currentPlayerLifeStage.lifeStepModel;

  /// 進む数の残り
  int _remainCount = 0;

  void rollDice() {
    if (value.allHumansReachedTheGoal || value.requireSelectDirection) return;

    value
      ..roll = _dice.roll()
      ..announcement = _i18n.rollAnnouncement(value.currentTurnHuman.name, value.roll); // FIXME: 状態に応じた適切なメッセージを流すように

    // サイコロ振る出発地点が分岐なら
    if (currentPlayerLifeStep.requireToSelectDirectionManually) {
      _remainCount = value.roll;
      value.requireSelectDirection = true;
      notifyListeners();
      return;
    }

    final dest = _moveLifeStepUntilMustStop(value.roll);
    _updateByDestination(dest);
    notifyListeners();
  }

  void chooseDirection(Direction direction) {
    if (value.allHumansReachedTheGoal || !value.requireSelectDirection) return;

    final dest = _moveLifeStepUntilMustStop(_remainCount, firstDirection: direction);
    _updateByDestination(dest);
    notifyListeners();
  }

  // FIXME: 命名も処理範囲も雑。共通処理を切り出しただけ。
  void _updateByDestination(DestinationWithMovedStepCount dest) {
    // NOTE: 選択を要するところに止まっても、そこが最終地点なら選択は次のターンに後回しとする
    value.requireSelectDirection = dest.remainCount > 0 && dest.destination.requireToSelectDirectionManually;
    if (value.requireSelectDirection) {
      _remainCount = dest.remainCount;
      notifyListeners();
      return;
    }
    _remainCount = 0; // リセット

    // LifeEvent 処理
    value.lifeStages = [...value.lifeStages];
    value.lifeStages[_currentPlayerLifeStageIndex] = _lifeEventService.executeEvent(
      _currentPlayerLifeStage.lifeStepModel.lifeEvent,
      _currentPlayerLifeStage,
    );

    // LifeEventの履歴を更新
    value.everyLifeEventRecords = [
      ...value.everyLifeEventRecords,
      LifeEventRecordModel(_i18n, _currentPlayerLifeStage.human, _currentPlayerLifeStage.lifeStepModel.lifeEvent)
    ];

    _changeToNextTurn(); // FIXME: 即ターン交代してるけど、あくまで仮
  }

  // 次のターンに変える
  void _changeToNextTurn() {
    final currentPlayerIndex = value.orderedHumans.indexOf(value.currentTurnHuman);
    value.currentTurnHuman = value.orderedHumans[(currentPlayerIndex + 1) % value.orderedHumans.length];
  }

  DestinationWithMovedStepCount _moveLifeStepUntilMustStop(int roll, {Direction firstDirection}) {
    // 現在の LifeStep から指定の数だけ進んだ LifeStep を取得する
    final destinationWithMovedStepCount =
        _currentPlayerLifeStage.lifeStepModel.getNextUntilMustStopStep(roll, firstDirection: firstDirection);
    // 進み先の LifeStep を LifeStage に代入する
    value.lifeStages[_currentPlayerLifeStageIndex].lifeStepModel = destinationWithMovedStepCount.destination;
    return destinationWithMovedStepCount;
  }
}
