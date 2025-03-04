import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/get_location_list.dart';
import 'package:weather_app/features/location/domain/usecases/params/location_params.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetLocationList getLocationList;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    getLocationList = GetLocationList(mockLocationRepository);
  });

  final testLocationList =
      (json.decode(fixture('dummy_location_response.json')) as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();

  test('should get list of locations from the repository', () async {
    when(mockLocationRepository.getListLocation('London'))
        .thenAnswer((_) async => Right(testLocationList));

    final result = await getLocationList(LocationParams(query: 'London'));

    expect(result, Right(testLocationList));
  });
}
