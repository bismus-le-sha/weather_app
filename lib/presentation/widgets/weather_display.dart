import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/widgets/weather_widgets.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(214, 210, 207, 1),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Row(
            children: [
              Container(
                  height: size.height * 0.6,
                  width: size.width * 0.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(47, 83, 63, 1),
                  )),
              Container(
                  height: size.height * 0.6,
                  width: size.width * 0.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(47, 83, 63, 1),
                  ))
            ],
          ),
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                color: Color(0xFFFFAB40),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          WeatherWidget(weather: weather)
        ],
      ),
    );
  }
}
