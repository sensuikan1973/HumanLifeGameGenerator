import '../common/human.dart';
import '../common/human_life.dart';
import '../common/life_road.dart';
import '../common/life_step.dart';
import 'life_event_record.dart';
import 'life_stage.dart';

class PlayRoomState {
  PlayRoomState(
    this.humanLife,
    this.orderedHumans,
  );

  final HumanLifeModel humanLife;
  final List<HumanModel> orderedHumans;

  /// 現在手番の人に方向選択を求めているかどうか
  bool requireSelectDirection = false;

  /// サイコロの出目
  int roll = 0;

  /// 現在手番の Human
  HumanModel currentTurnHuman;

  /// 全 Human の人生の進捗
  List<LifeStageModel> lifeStages = [];

  /// 全 Human の LifeEvent 履歴
  List<LifeEventRecordModel> everyLifeEventRecords = [];

  /// お知らせ
  String announcement = 'announcement';

  /// 部屋タイトル
  String roomTitle = 'Room Title';

  /// 参加者全員がゴールに到着したかどうか
  bool get allHumansReachedTheGoal => lifeStages.every((lifeStage) => lifeStage.lifeStepModel.isGoal);

  /// 参加者全員の Position
  Map<String, Position> get positionsByHumanId => {
        for (final lifeStage in lifeStages) lifeStage.human.id: humanLife.lifeRoad.getPosition(lifeStage.lifeStepModel),
      };

  /// 現在手番の Human が位置する LifeStep
  LifeStepModel get currentHumanLifeStep =>
      lifeStages.firstWhere((lifeStage) => lifeStage.human == currentTurnHuman).lifeStepModel;
}
