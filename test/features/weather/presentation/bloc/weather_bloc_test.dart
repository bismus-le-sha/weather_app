import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/constants/messages.dart';

import 'package:weather_app/core/error/failures.dart';

import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/params.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeather mockGetCurrentWeather;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  const cityName = 'London';
  final testWeather = WeatherEntity(
    cityName: 'London',
    localtime: DateTime.parse('2021-02-21 08:42:00'),
    temperature: 11.0,
    feelsLike: 9.5,
    conditionCode: 1003,
    conditionText: 'Partly cloudy',
    conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
    windSpeed: 6.1,
  );

  group('WeatherBloc', () {
    test('initial state should be WeatherEmpty', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when GetCurrentWeather succeeds',
      build: () {
        when(mockGetCurrentWeather(any))
            .thenAnswer((_) async => Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(WeatherLoad(cityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(mockGetCurrentWeather(WeatherParams(cityName: cityName)));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoadFailure] when GetCurrentWeather fails',
      build: () {
        when(mockGetCurrentWeather(any)).thenAnswer(
            (_) async => Left(Failure.fromType(FailureType.serverError)));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(WeatherLoad(cityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        WeatherLoadFailure(SERVER_FAILURE_MESSAGE),
      ],
      verify: (_) {
        verify(mockGetCurrentWeather(WeatherParams(cityName: cityName)));
      },
    );
  });
}
