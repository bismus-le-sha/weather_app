import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const WeatherApp());
}
