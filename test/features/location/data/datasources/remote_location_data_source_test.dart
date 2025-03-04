import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/location/data/datasources/remote_location_data_source.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoteLocationDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = RemoteLocationDataSourceImpl(client: mockHttpClient);
  });

  group('getLocationList', () {
    const query = 'Paris';
    final testLocationList =
        (json.decode(fixture('dummy_location_response.json')) as List<dynamic>)
            .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
            .toList();

    test('should return List<LocationModel> when the response code is 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async =>
            http.Response(fixture('dummy_location_response.json'), 200),
      );

      // Act
      final result = await dataSource.getLocationList(query);

      // Assert
      expect(result, equals(testLocationList));
    });

    test('should return an empty list when response is 200 but contains []',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('[]', 200),
      );

      // Act
      final result = await dataSource.getLocationList(query);

      // Assert
      expect(result, equals([]));
    });

    test('should throw ServerException when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Something went wrong', 404),
      );

      // Act
      final call = dataSource.getLocationList;

      // Assert
      expect(() => call(query), throwsA(isA<ServerException>()));
    });

    test('should throw ServerException when response is invalid JSON',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('{invalid_json}', 200),
      );

      // Act
      final call = dataSource.getLocationList;

      // Assert
      expect(() => call(query), throwsA(isA<FormatException>()));
    });

    test(
        'should throw ServerException when there is a timeout or network error',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenThrow(SocketException('No Internet'));

      // Act
      final call = dataSource.getLocationList;

      // Assert
      expect(() => call(query), throwsA(isA<ServerException>()));
    });
  });
}
