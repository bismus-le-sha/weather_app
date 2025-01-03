import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/params.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeather getCurrentWeather;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeather = GetCurrentWeather(mockWeatherRepository);
  });

  final dateFormat = DateFormat('yyyy-MM-dd H:mm');
  final testWeatherEntity = WeatherEntity(
    cityName: 'London',
    localtime: dateFormat.parse('2021-02-21 8:42'),
    temperature: 11.0,
    feelsLike: 9.5,
    conditionCode: 1003,
    conditionText: 'Partly cloudy',
    conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
    windSpeed: 6.1,
  );

  test('should get current weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testWeatherEntity.cityName))
        .thenAnswer((_) async => Right(testWeatherEntity));

    // act
    final result = await getCurrentWeather
        .call(WeatherParams(cityName: testWeatherEntity.cityName));

    // assert
    expect(result, Right(testWeatherEntity));
  });
}
