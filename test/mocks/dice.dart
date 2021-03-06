import 'package:HumanLifeGame/api/dice.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockDice extends Mock implements Dice {
  MockDice([int roll]) {
    if (roll != null) when(this.roll()).thenReturn(roll);
  }
}
