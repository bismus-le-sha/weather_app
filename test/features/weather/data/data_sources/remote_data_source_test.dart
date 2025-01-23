import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/url_handler.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getCurrentWeather', () {
    const cityName = 'London';
    final testWeatherJson = {
      "location": {"name": "London"},
      "current": {
        "last_updated": "2021-02-21 8:42",
        "temp_c": 11.0,
        "feelslike_c": 9.5,
        "is_day": 1,
        "condition": {
          "code": 1003,
          "text": "Partly cloudy",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
        },
        "wind_kph": 6.1
      }
    };
    final testWeatherModel = WeatherModel.fromJson(testWeatherJson);

    test('should perform GET request with the correct URL', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(jsonEncode(testWeatherJson), 200),
      );

      // Act
      await dataSource.getCurrentWeather(cityName);

      // Assert
      verify(mockHttpClient.get(
        Uri.parse(Urls.currentWeatherByName(cityName)),
      ));
    });

    test('should return WeatherModel when the response code is 200', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(jsonEncode(testWeatherJson), 200),
      );

      // Act
      final result = await dataSource.getCurrentWeather(cityName);

      // Assert
      expect(result, equals(testWeatherModel));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );

      // Act
      final call = dataSource.getCurrentWeather;

      // Assert
      expect(() => call(cityName), throwsA(isA<ServerException>()));
    });
  });
}
