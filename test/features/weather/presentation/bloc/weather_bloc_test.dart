import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/constants/messages.dart';

import 'package:weather_app/core/error/failures.dart';

import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/params/weater_params.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeather mockGetCurrentWeather;
  late MockPeriodicWeatherUpdater mockPeriodicWeatherUpdater;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    mockPeriodicWeatherUpdater = MockPeriodicWeatherUpdater();
    weatherBloc =
        WeatherBloc(mockGetCurrentWeather, mockPeriodicWeatherUpdater);
  });

  final testWeather = WeatherEntity(
    cityName: 'London',
    lastUpdated: DateTime.parse('2021-02-21 08:42:00'),
    temperature: 11.0,
    feelsLike: 9.5,
    isDay: 1,
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
      act: (bloc) => bloc.add(WeatherLoad(testWeather.cityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(mockGetCurrentWeather(
            WeatherParams(cityName: testWeather.cityName)));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoadFailure] when GetCurrentWeather fails',
      build: () {
        when(mockGetCurrentWeather(any)).thenAnswer(
            (_) async => Left(Failure.fromType(FailureType.serverError)));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(WeatherLoad(testWeather.cityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WeatherLoading(),
        WeatherLoadFailure(SERVER_FAILURE_MESSAGE),
      ],
      verify: (_) {
        verify(mockGetCurrentWeather(
            WeatherParams(cityName: testWeather.cityName)));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'starts auto-update and emits WeatherAutoUpdating when StartAutoUpdate is added',
      build: () {
        when(mockPeriodicWeatherUpdater.start(any, any))
            .thenAnswer((_) => Stream.value(Right(testWeather)));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(StartAutoUpdate(testWeather.cityName)),
      expect: () => [
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(mockPeriodicWeatherUpdater.start(
            testWeather.cityName, Duration(hours: 1)));
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits WeatherLoadFailure when auto-update fails',
      build: () {
        when(mockPeriodicWeatherUpdater.start(any, any)).thenAnswer((_) =>
            Stream.value(Left(Failure.fromType(FailureType.serverError))));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(StartAutoUpdate(testWeather.cityName)),
      expect: () => [
        WeatherLoadFailure(SERVER_FAILURE_MESSAGE),
      ],
      verify: (_) {
        verify(mockPeriodicWeatherUpdater.start(
            testWeather.cityName, Duration(hours: 1)));
      },
    );
  });
}
