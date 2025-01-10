import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/service/periodic_weather_handler/periodic_weather_handler.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/params/weater_params.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late PeriodicWeatherUpdaterImpl periodicWeatherUpdater;
  late MockGetCurrentWeather mockGetCurrentWeather;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    periodicWeatherUpdater = PeriodicWeatherUpdaterImpl(mockGetCurrentWeather);
  });
  const interval = Duration(milliseconds: 200);
  final weatherEntity = WeatherEntity(
    cityName: 'London',
    lastUpdated: DateTime.parse('2021-02-21 08:42'),
    temperature: 11.0,
    feelsLike: 9.5,
    conditionCode: 1003,
    conditionText: 'Partly cloudy',
    conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
    windSpeed: 6.1,
  );

  test('should periodically emit weather data', () async {
    // Arrange
    when(mockGetCurrentWeather
            .call(WeatherParams(cityName: weatherEntity.cityName)))
        .thenAnswer((_) async => Right(weatherEntity));
    final stream =
        periodicWeatherUpdater.start(weatherEntity.cityName, interval);

    // Act
    final result = await stream.take(3).toList();

    // Assert
    verify(mockGetCurrentWeather(
            WeatherParams(cityName: weatherEntity.cityName)))
        .called(3);
    expect(
        result,
        equals([
          Right(weatherEntity),
          Right(weatherEntity),
          Right(weatherEntity)
        ]));
  });

  test('should stop emitting updates after calling stop', () async {
    // Arrange
    when(mockGetCurrentWeather(any))
        .thenAnswer((_) async => Right(weatherEntity));
    final stream =
        periodicWeatherUpdater.start(weatherEntity.cityName, interval);
    final result = stream.take(2).toList();
    Future.delayed(Duration(milliseconds: 300), () {
      periodicWeatherUpdater.stop();
    });

    // Act
    final output = await result;

    // Assert
    verify(mockGetCurrentWeather(
            WeatherParams(cityName: weatherEntity.cityName)))
        .called(2);
    expect(output.length, 2);
  });

  test('should close stream controller when stop is called', () async {
    // Arrange
    when(mockGetCurrentWeather(any))
        .thenAnswer((_) async => Right(weatherEntity));
    periodicWeatherUpdater.start(weatherEntity.cityName, interval);

    // Act
    periodicWeatherUpdater.stop();

    // Assert
    expect(() => periodicWeatherUpdater.start(weatherEntity.cityName, interval),
        returnsNormally);
  });
}
