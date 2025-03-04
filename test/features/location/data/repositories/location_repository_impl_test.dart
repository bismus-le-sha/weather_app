import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/data/repositories/location_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LocationRepositoryImpl repository;
  late MockRemoteLocationDataSource mockRemoteDataSource;
  late MockLocalLocationDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteLocationDataSource();
    mockLocalDataSource = MockLocalLocationDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LocationRepositoryImpl(
      remoteLocationDataSource: mockRemoteDataSource,
      localLocationDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const query = 'Paris';
  final testLocationModel = LocationModel(
    city: 'Paris',
    countryName: 'France',
    lat: 48.8566,
    lon: 2.3522,
    region: 'Ile-de-France',
  );
  final testLocationList =
      (json.decode(fixture('dummy_location_response.json')) as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();

  group('getListLocation', () {
    test('should check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getLocationList(any))
          .thenAnswer((_) async => testLocationList);

      await repository.getListLocation(query);

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when call to remote source is successful',
          () async {
        when(mockRemoteDataSource.getLocationList(any))
            .thenAnswer((_) async => testLocationList);

        final result = await repository.getListLocation(query);

        verify(mockRemoteDataSource.getLocationList(query));
        expect(result, equals(Right(testLocationList)));
      });

      test('should return server failure when the server throws an exception',
          () async {
        when(mockRemoteDataSource.getLocationList(any))
            .thenThrow(ServerException());

        final result = await repository.getListLocation(query);

        expect(result, equals(Left(Failure.fromType(FailureType.serverError))));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return connection failure when offline', () async {
        final result = await repository.getListLocation(query);
        expect(result,
            equals(Left(Failure.fromType(FailureType.connectionError))));
      });
    });
  });

  group('addFavoriteLocation', () {
    test('should return success when adding to local data source is successful',
        () async {
      when(mockLocalDataSource.addFavoriteLocation(any))
          .thenAnswer((_) async => Future.value());

      final result = await repository.addFavoritestLocation(testLocationModel);

      verify(mockLocalDataSource.addFavoriteLocation(testLocationModel));
      expect(result, equals(Right(null)));
    });

    test('should return cache failure when an exception occurs', () async {
      when(mockLocalDataSource.addFavoriteLocation(any))
          .thenThrow(CacheException());

      final result = await repository.addFavoritestLocation(testLocationModel);

      expect(result, equals(Left(Failure.fromType(FailureType.cacheError))));
    });
  });

  group('getFavoriteLocationList', () {
    test('should return list of favorite locations when successful', () async {
      when(mockLocalDataSource.getFavoriteLocationList())
          .thenAnswer((_) async => testLocationList);

      final result = await repository.getFavoritestLocationList();

      verify(mockLocalDataSource.getFavoriteLocationList());
      expect(result, equals(Right(testLocationList)));
    });

    test('should return cache failure when an exception occurs', () async {
      when(mockLocalDataSource.getFavoriteLocationList())
          .thenThrow(CacheException());

      final result = await repository.getFavoritestLocationList();

      expect(result, equals(Left(Failure.fromType(FailureType.cacheError))));
    });
  });

  group('removeFavoriteLocation', () {
    test(
        'should return success when removing from local data source is successful',
        () async {
      when(mockLocalDataSource.removeFavoriteLocation(any))
          .thenAnswer((_) async => Future.value());

      final result =
          await repository.removeFavoritestLocation(testLocationModel);

      verify(mockLocalDataSource.removeFavoriteLocation(testLocationModel));
      expect(result, equals(Right(null)));
    });

    test('should return cache failure when an exception occurs', () async {
      when(mockLocalDataSource.removeFavoriteLocation(any))
          .thenThrow(CacheException());

      final result =
          await repository.removeFavoritestLocation(testLocationModel);

      expect(result, equals(Left(Failure.fromType(FailureType.cacheError))));
    });
  });
}
