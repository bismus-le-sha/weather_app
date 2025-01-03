import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/data_sources/local_data_source.dart';

import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late WeatherModel testWeatherModel;
  late String testJsonString;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    final dateFormat = DateFormat('yyyy-MM-dd H:mm');
    testWeatherModel = WeatherModel(
      cityName: 'London',
      localtime: dateFormat.parse('2021-02-21 8:42'),
      temperature: 11.0,
      feelsLike: 9.5,
      conditionCode: 1003,
      conditionText: 'Partly cloudy',
      conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
      windSpeed: 6.1,
    );
    testJsonString = jsonEncode(testWeatherModel.toJson());
  });

  group('cacheWeather', () {
    test('should call SharedPreferences to cache data', () async {
      // Arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // Act
      await dataSource.cacheWeather(
          testWeatherModel.cityName, testWeatherModel);

      // Assert
      final expectedJsonString = jsonEncode(testWeatherModel.toJson());
      verify(mockSharedPreferences.setString(
          testWeatherModel.cityName, expectedJsonString));
    });
  });

  group('getLastWeather', () {
    test(
        'should return WeatherModel from SharedPreferences when there is cached data',
        () async {
      // Arrange
      when(mockSharedPreferences.getString(testWeatherModel.cityName))
          .thenReturn(testJsonString);

      // Act
      final result = await dataSource.getLastWeather(testWeatherModel.cityName);

      // Assert
      expect(result, equals(testWeatherModel));
    });

    test('should throw CacheException when there is no cached data', () async {
      // Arrange
      when(mockSharedPreferences.getString(testWeatherModel.cityName))
          .thenReturn(null);

      // Act
      final call = dataSource.getLastWeather;

      // Assert
      expect(() => call(testWeatherModel.cityName),
          throwsA(isA<CacheException>()));
    });
  });
}
