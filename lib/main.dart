import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'injection_container.dart' as di;
import 'weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final talker = di.sl<Talker>();

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError =
      (details) => talker.handle(details.exception, details.stack);

  runApp(const WeatherApp());
}
