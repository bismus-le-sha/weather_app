import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/const.dart';
import 'package:weather_app/features/location/data/datasources/local_location_data_source.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalLocationDataSourceImpl dataSource;
  late List<LocationModel> testLocationList;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        LocalLocationDataSourceImpl(sharedPreferences: mockSharedPreferences);
    testLocationList = [
      LocationModel(
          city: 'Paris',
          countryName: 'France',
          lat: 48.8566,
          lon: 2.3522,
          region: 'Ile-de-France'),
      LocationModel(
          city: 'Berlin',
          countryName: 'Germany',
          lat: 52.52,
          lon: 13.405,
          region: 'Berlin'),
    ];
  });

  group('getFavoriteLocationList', () {
    test(
        'should return a list of LocationModel from SharedPreferences when there is cached data',
        () async {
      // arrange
      when(mockSharedPreferences.containsKey(LOCATION_LIST)).thenReturn(true);
      when(mockSharedPreferences.getString(LOCATION_LIST)).thenReturn(
          jsonEncode(testLocationList.map((loc) => loc.toJson()).toList()));

      // act
      final result = await dataSource.getFavoriteLocationList();

      // assert
      verify(mockSharedPreferences.containsKey(LOCATION_LIST));
      verify(mockSharedPreferences.getString(LOCATION_LIST));
      expect(result, equals(testLocationList));
    });

    test('should return an empty list when there is no cached data', () async {
      // arrange
      when(mockSharedPreferences.containsKey(LOCATION_LIST)).thenReturn(true);
      when(mockSharedPreferences.getString(LOCATION_LIST))
          .thenReturn(jsonEncode([]));

      // act
      final result = await dataSource.getFavoriteLocationList();

      // assert
      verify(mockSharedPreferences.containsKey(LOCATION_LIST));
      verify(mockSharedPreferences.getString(LOCATION_LIST));
      expect(result, equals([]));
    });
  });

  group('addFavoriteLocation', () {
    test('should add a location to the stored list', () async {
      // arrange
      when(mockSharedPreferences.containsKey(LOCATION_LIST)).thenReturn(true);
      when(mockSharedPreferences.getString(LOCATION_LIST))
          .thenReturn(jsonEncode([]));
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      await dataSource.addFavoriteLocation(testLocationList.first);

      // assert
      final expectedJsonString = jsonEncode([testLocationList.first.toJson()]);
      verify(
          mockSharedPreferences.setString(LOCATION_LIST, expectedJsonString));
    });
  });

  group('removeFavoriteLocation', () {
    test('should remove a location from the stored list', () async {
      // arrange
      when(mockSharedPreferences.containsKey(LOCATION_LIST)).thenReturn(true);
      when(mockSharedPreferences.getString(LOCATION_LIST)).thenReturn(
          jsonEncode(testLocationList.map((loc) => loc.toJson()).toList()));
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      await dataSource.removeFavoriteLocation(testLocationList.first);

      // assert
      final expectedJsonString = jsonEncode([testLocationList.last.toJson()]);
      verify(
          mockSharedPreferences.setString(LOCATION_LIST, expectedJsonString));
    });
  });
}
