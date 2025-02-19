import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/util/weather/weather_utills.dart';

class WeatherIcon extends StatelessWidget {
  final int conditionCode;
  final int isDay;
  final double size;

  const WeatherIcon({
    super.key,
    required this.conditionCode,
    required this.isDay,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 10,
          right: 10,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return RadialGradient(
                  colors: [Colors.black.withAlpha(125), Colors.transparent],
                  center: Alignment.center,
                  radius: 0.8,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                getWeatherIconPath(conditionCode, isDay),
                color: Colors.black,
                colorBlendMode: BlendMode.srcATop,
                height: size,
                width: size,
              ),
            ),
          ),
        ),
        Image.asset(
          getWeatherIconPath(conditionCode, isDay),
          height: size,
          width: size,
        ),
      ],
    );
  }
}
