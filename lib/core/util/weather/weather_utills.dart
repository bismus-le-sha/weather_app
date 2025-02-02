import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

String getWeatherIconPath(int conditionCode, int isDay) {
  final Map<dynamic, String> weatherIcons = {
    1000: isDay == 1
        ? 'assets/images/weather/sun.png'
        : 'assets/images/weather/clear-night.png',
    1003: isDay == 1
        ? 'assets/images/weather/cloudy-day.png'
        : 'assets/images/weather/cloudy-night.png',
    1006: isDay == 1
        ? 'assets/images/weather/cloudy-day.png'
        : 'assets/images/weather/cloudy-night.png',
    1009: 'assets/images/weather/cloudy.png',
    1030: isDay == 1
        ? 'assets/images/weather/fog-day.png'
        : 'assets/images/weather/fog-night.png',
    1135: isDay == 1
        ? 'assets/images/weather/fog-day.png'
        : 'assets/images/weather/fog-night.png',
    1147: isDay == 1
        ? 'assets/images/weather/fog-day.png'
        : 'assets/images/weather/fog-night.png',
    1087: 'assets/images/weather/cloudy_thunder.png',
    1264: 'assets/images/weather/ice-pellets.png',
  };

  final List<MapEntry<Range, String>> rangeIcons = [
    MapEntry(
        Range(1063, 1240),
        isDay == 1
            ? 'assets/images/weather/rainy-day.png'
            : 'assets/images/weather/rainy-night.png'),
    MapEntry(Range(1204, 1225), 'assets/images/weather/snowfall.png'),
    MapEntry(Range(1186, 1195), 'assets/images/weather/rain.png'),
  ];

  final result = weatherIcons[conditionCode];
  if (result != null) return result;

  final rangeResult = rangeIcons
      .firstWhereOrNull((entry) => entry.key.contains(conditionCode))
      ?.value;
  if (rangeResult != null) return rangeResult;

  return isDay == 1
      ? 'assets/images/weather/sun.png'
      : 'assets/images/weather/clear-night.png';
}

class Range {
  final int start;
  final int end;

  Range(this.start, this.end);

  bool contains(int value) => value >= start && value <= end;
}

String getBackground(int isDay) {
  return isDay == 1
      ? 'assets/images/day-background.png'
      : 'assets/images/night-background.png';
}

List<String> getHill(int isDay) {
  return isDay == 1
      ? [
          'assets/images/hills/left-hill-day.png',
          'assets/images/hills/right-hill-day.png',
          'assets/images/hills/bottom-hill-night.png'
        ]
      : [
          'assets/images/hills/left-hill-night.png',
          'assets/images/hills/right-hill-night.png',
          'assets/images/hills/bottom-hill-night.png'
        ];
}

Color getHillBottomColor(int isDay) {
  return isDay == 1
      ? const Color.fromRGBO(42, 143, 73, 1)
      : const Color.fromRGBO(28, 66, 39, 1);
}

Color getBacgroundColor(int isDay) {
  return isDay == 1
      ? const Color.fromRGBO(214, 210, 207, 1)
      : const Color.fromARGB(92, 214, 210, 207);
}
