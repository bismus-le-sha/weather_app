import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testLocationModel = LocationModel(
    countryName: "Russia",
    city: "Omsk",
    region: "Omsk",
    lat: 55,
    lon: 73.4,
  );

  test('should be a subclass of LocationEntity', () async {
    // Assert
    expect(testLocationModel, isA<LocationEntity>());
  });

  test('should return a valid model from JSON', () async {
    // Arrange
    final List<dynamic> jsonList = json.decode(
      fixture('dummy_location_response.json'),
    );

    // Act
    final result =
        jsonList.map((json) => LocationModel.fromJson(json)).toList();

    // Assert
    expect(result, isA<List<LocationModel>>());
    expect(result.first, equals(testLocationModel));
  });

  test('should return a JSON map containing proper data', () async {
    // Act
    final result = testLocationModel.toJson();

    // Assert
    final expectedJsonMap = {
      'country': "Russia",
      'name': "Omsk",
      'region': "Omsk",
      'lat': 55,
      'lon': 73.4,
    };

    expect(result, equals(expectedJsonMap));
  });

  test('should return a modified copy with copyWith', () async {
    // Act
    final modified = testLocationModel.copyWith(
      city: "Saint Petersburg",
      lat: 59.9343,
      lon: 30.3351,
    );

    // Assert
    expect(modified.city, equals("Saint Petersburg"));
    expect(modified.lat, equals(59.9343));
    expect(modified.lon, equals(30.3351));
    expect(modified.countryName, equals(testLocationModel.countryName));
  });

  test('toString should return a correct string representation', () async {
    // Act
    final result = testLocationModel.toString();

    // Assert
    expect(
        result,
        equals(
            'LocationModel(city: Moscow, region: Moscow Region, country: Russia, lat: 55.7558, lon: 37.6173)'));
  });
}
