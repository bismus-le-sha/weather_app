import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testLocationModel = LocationModel(
    countryName: "France",
    city: "Paris",
    region: "Ile-de-France",
    lat: 48.87,
    lon: 2.33,
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
      "name": "Paris",
      "region": "Ile-de-France",
      "country": "France",
      "lat": 48.87,
      "lon": 2.33,
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
            'LocationModel(city: Paris, region: Ile-de-France, country: France, lat: 48.87, lon: 2.33)'));
  });
}
