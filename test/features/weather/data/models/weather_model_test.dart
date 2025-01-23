import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final dateFormat = DateFormat('yyyy-MM-dd H:mm');
  final testWeatherModel = WeatherModel(
    cityName: 'London',
    lastUpdated: dateFormat.parse('2021-02-21 8:30'),
    temperature: 11.0,
    feelsLike: 9.5,
    isDay: 1,
    conditionCode: 1003,
    conditionText: 'Partly cloudy',
    conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
    windSpeed: 6.1,
  );

  test('should be a subclass of WeatherEntity', () async {
    // Assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from JSON', () async {
    // Arrange
    final Map<String, dynamic> jsonMap = json.decode(
      fixture('dummy_weather_response.json'),
    );

    // Act
    final result = WeatherModel.fromJson(jsonMap);

    // Assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a JSON map containing proper data', () async {
    // Act
    final result = testWeatherModel.toJson();

    // Assert
    final expectedJsonMap = {
      'location': {'name': 'London'},
      'current': {
        'last_updated': '2021-02-21 8:30',
        'temp_c': 11.0,
        'feelslike_c': 9.5,
        'is_day': 1,
        'condition': {
          'code': 1003,
          'text': 'Partly cloudy',
          'icon': '//cdn.weatherapi.com/weather/64x64/day/116.png',
        },
        'wind_kph': 6.1,
      },
    };

    expect(result, equals(expectedJsonMap));
  });
}
