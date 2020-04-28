import 'package:HumanLifeGame/domain/play_room/play_room.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:flutter/material.dart';

import 'i18n/i18n_delegate.dart';

class HumanLifeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: (context) => I18n.of(context).appTitle,
        localizationsDelegates: const [
          I18nDelegate(),
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ja', 'JP'),
        ],
        locale: const Locale('en'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlayRoom(),
      );
}
