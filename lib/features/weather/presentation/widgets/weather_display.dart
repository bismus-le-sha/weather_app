import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/config/router/router.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_main_info.dart';
import 'package:weather_app/features/weather/presentation/widgets/hidden_hills.dart';

import '../../../../core/util/weather/weather_utills.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: getBacgroundColor(weather.isDay),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: WeatherMainInfo(
                    weather: weather,
                    screenSize: screenSize,
                    scrollController: scrollController,
                  ),
                ),
                SliverToBoxAdapter(
                  child: HiddenHills(
                    scrollController: scrollController,
                    screenSize: screenSize,
                    hillPaths: getHill(weather.isDay),
                    bottomHillColor: getHillBottomColor(weather.isDay),
                    weather: weather,
                  ),
                ),
              ],
            ),
            Text(
              '${weather.temperature.round()}°C',
              style: TextStyle(
                color: Colors.white,
                fontSize: 55,
                fontWeight: FontWeight.w600,
              ),
            ),
            Positioned(
              top: 0.2 * kToolbarHeight,
              left: 40,
              child: GestureDetector(
                onTap: () async {
                  context.pushRoute(const CityRoute());
                },
                child: Text(
                  '📍 ${weather.cityName}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
