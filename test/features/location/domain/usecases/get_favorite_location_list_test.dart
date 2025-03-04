import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/get_favorite_location_list.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetFavoriteLocationList getFavoriteLocationList;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    getFavoriteLocationList = GetFavoriteLocationList(mockLocationRepository);
  });

  final testLocationList =
      (json.decode(fixture('dummy_location_response.json')) as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();

  test('should get list of favorite locations from the repository', () async {
    when(mockLocationRepository.getFavoritestLocationList())
        .thenAnswer((_) async => Right(testLocationList));

    final result = await getFavoriteLocationList(NoParams());

    expect(result, Right(testLocationList));
  });
}
