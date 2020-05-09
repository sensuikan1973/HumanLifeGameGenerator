import 'package:HumanLifeGame/models/common/life_event_params/gain_life_item_params.dart';
import 'package:HumanLifeGame/models/common/life_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson', () {
    const target = GainLifeItemTarget(key: 'money', type: LifeItemType.money, amount: 3000);
    const gainLifeItemParams = GainLifeItemParams(targetItems: [target]);
    final paramsJson = gainLifeItemParams.toJson();
    expect(paramsJson['targetItems'].first.key, target.key);
    expect(paramsJson['targetItems'].first.amount, 3000);
    expect(paramsJson['targetItems'].first.type, LifeItemType.money);
  });
}