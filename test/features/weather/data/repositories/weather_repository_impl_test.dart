import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;
  late MockWeatherLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockLocalDataSource = MockWeatherLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockRemoteDataSource,
      weatherLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const cityName = 'London';
  final testWeatherModel = WeatherModel(
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
  final WeatherEntity testWeatherEntity = testWeatherModel;

  group('getCurrentWeather', () {
    test('should check if device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCurrentWeather(any))
          .thenAnswer((_) async => testWeatherModel);

      // Act
      await repository.getCurrentWeather(cityName);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data and cache it when call to remote data source is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCurrentWeather(any))
            .thenAnswer((_) async => testWeatherModel);

        // Act
        final result = await repository.getCurrentWeather(cityName);

        // Assert
        verify(mockRemoteDataSource.getCurrentWeather(cityName));
        verify(mockLocalDataSource.cacheWeather(cityName, testWeatherModel));
        expect(result, equals(Right(testWeatherEntity)));
      });

      test('should return server failure when the server throws an exception',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCurrentWeather(any))
            .thenThrow(ServerException());

        // Act
        final result = await repository.getCurrentWeather(cityName);

        // Assert
        expect(result, equals(Left(Failure.fromType(FailureType.serverError))));
      });

      test('should return connection failure when a SocketException occurs',
          () async {
        // Arrange
        when(mockRemoteDataSource.getCurrentWeather(any))
            .thenThrow(SocketException('No connection'));

        // Act
        final result = await repository.getCurrentWeather(cityName);

        // Assert
        expect(result,
            equals(Left(Failure.fromType(FailureType.connectionError))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return local data when the call to local data source is successful',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastWeather(any))
            .thenAnswer((_) async => testWeatherModel);

        // Act
        final result = await repository.getCurrentWeather(cityName);

        // Assert
        verify(mockLocalDataSource.getLastWeather(cityName));
        expect(result, equals(Right(testWeatherEntity)));
      });

      test('should return cache failure when there is no data in cache',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastWeather(any))
            .thenThrow(CacheException());

        // Act
        final result = await repository.getCurrentWeather(cityName);

        // Assert
        expect(result, equals(Left(Failure.fromType(FailureType.cacheError))));
      });
    });
  });
}
