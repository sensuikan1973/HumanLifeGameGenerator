import 'package:intl/intl.dart';

import '../../entities/life_event_type.dart';
import '../i18n.dart';

/// Common Locale Text
extension I18nCommon on I18n {
  String get appTitle => Intl.message(
        'Human Life Game',
        name: 'appTitle',
        locale: localeName,
      );
  String lifeStepEventType(LifeEventType type) => Intl.select(
        type,
        {
          LifeEventType.nothing: '',
          LifeEventType.start: 'Start',
          LifeEventType.goal: 'Goal',
          LifeEventType.selectDirection: 'Select Direction',
          LifeEventType.gainLifeItems: 'Gain Item :',
          LifeEventType.exchangeLifeItems: 'Exchange Item :',
          LifeEventType.loseLifeItems: 'Lose Item :',
        },
        name: 'lifeStepEventType',
        args: [type],
        locale: localeName,
      );
}
