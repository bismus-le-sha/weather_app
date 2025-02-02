import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/presentation/widgets/more_weather_info.dart';

import '../../../../core/util/weather/scroll_calculator.dart';

class HiddenHills extends StatelessWidget {
  final ScrollController scrollController;
  final Size screenSize;
  final List<String> hillPaths;
  final Color bottomHillColor;
  final WeatherEntity weather;

  const HiddenHills({
    super.key,
    required this.scrollController,
    required this.screenSize,
    required this.hillPaths,
    required this.bottomHillColor,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final double scrollProgress = calculateScrollProgress(scrollController);
        return SizedBox(
          height: screenSize.height * 0.8,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                top: screenSize.height * 0.3,
                child: Container(color: bottomHillColor),
              ),
              _buildHill(hillPaths[0], scrollProgress, isLeft: true),
              _buildHill(hillPaths[1], scrollProgress, isLeft: false),
              _buildMoreWeatherInfo(scrollProgress),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHill(String path, double scrollProgress,
      {required bool isLeft}) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      left: isLeft
          ? -screenSize.width *
              0.4 *
              Curves.slowMiddle.transform(scrollProgress)
          : null,
      right: !isLeft
          ? -screenSize.width *
              0.4 *
              Curves.slowMiddle.transform(scrollProgress)
          : null,
      bottom:
          screenSize.height * 0.2 * Curves.slowMiddle.transform(scrollProgress),
      child: Image.asset(path),
    );
  }

  Widget _buildMoreWeatherInfo(double scrollProgress) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      bottom:
          screenSize.height * 0.2 * Curves.slowMiddle.transform(scrollProgress),
      child: MoreWeatherInfo(weather: weather),
    );
  }
}
