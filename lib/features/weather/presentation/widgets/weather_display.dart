import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_widgets.dart';

import 'weather_icon.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(214, 210, 207, 1),
        body: SafeArea(
            child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverToBoxAdapter(child: weatherMainInfo(weather, screenSize)),
            SliverToBoxAdapter(
                child:
                    hidenHills(controller, screenSize, getHill(weather.isDay))),
          ],
        )));
  }
}
