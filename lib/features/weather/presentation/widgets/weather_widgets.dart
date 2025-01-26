import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/weather.dart';
import 'weather_icon.dart';

Widget weatherMainInfo(WeatherEntity weather, Size screenSize) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0.2 * kToolbarHeight, 40, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📍 ${weather.cityName}',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Center(
          child: getWeatherIcon(
            getWeatherIconPath(weather.conditionCode, weather.isDay),
            screenSize.width * 0.7,
          ),
        ),
        Center(
          child: Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 55,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget hidenHills(
    ScrollController controller, Size screenSize, List<String> paths) {
  var sheetProgress = 0.2;
  return AnimatedBuilder(
    animation: controller,
    builder: (context, child) {
      if (controller.hasClients && controller.position.hasContentDimensions) {
        sheetProgress = controller.position.pixels /
            (controller.position.maxScrollExtent == 0
                ? 1
                : controller.position.maxScrollExtent);
      }
      return SizedBox(
        height: screenSize.height * 0.8,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              left: -screenSize.width *
                  0.4 *
                  Curves.slowMiddle.transform(sheetProgress),
              bottom: screenSize.height *
                  0.2 *
                  Curves.slowMiddle.transform(sheetProgress),
              child: Image.asset(
                paths[0],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              right: -screenSize.width *
                  0.4 *
                  Curves.slowMiddle.transform(sheetProgress),
              bottom: screenSize.height *
                  0.2 *
                  Curves.slowMiddle.transform(sheetProgress),
              child: Image.asset(
                paths[1],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget moreWeatherInfo(WeatherEntity weather) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40, 0.2 * kToolbarHeight, 40, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Ощущается как ${weather.feelsLike.round()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Center(
          child: Text(
            weather.conditionText.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Text(
            'Последнее обновление: ${DateFormat().add_jm().format(weather.lastUpdated)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Center(
          child: Text(
            '${weather.windSpeed} km/h',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
