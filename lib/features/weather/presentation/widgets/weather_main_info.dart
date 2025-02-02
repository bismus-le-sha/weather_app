import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_icon.dart';

import '../../../../core/util/weather/scroll_calculator.dart';
import '../../../../core/util/weather/weather_utills.dart';

class WeatherMainInfo extends StatelessWidget {
  final WeatherEntity weather;
  final Size screenSize;
  final ScrollController scrollController;

  const WeatherMainInfo({
    super.key,
    required this.weather,
    required this.screenSize,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final double scrollProgress = calculateScrollProgress(scrollController);
        return SizedBox(
          height: screenSize.height * 0.5,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              _buildWeatherIcon(scrollProgress),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherIcon(double scrollProgress) {
    final double initialIconSize = screenSize.width * 0.7;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      top: screenSize.height * 0.3 * Curves.easeOut.transform(scrollProgress),
      right: screenSize.width * 0.1 * (-scrollProgress),
      child: Transform.scale(
        scale: 1.0 - 0.5 * scrollProgress,
        child: getWeatherIcon(
          getWeatherIconPath(weather.conditionCode, weather.isDay),
          initialIconSize,
        ),
      ),
    );
  }
}
