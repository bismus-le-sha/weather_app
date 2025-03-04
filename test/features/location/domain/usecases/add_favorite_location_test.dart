import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/add_favorite_location.dart';
import 'package:weather_app/features/location/domain/usecases/params/favorite_location_params.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AddFavoriteLocation addFavoriteLocation;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    addFavoriteLocation = AddFavoriteLocation(mockLocationRepository);
  });

  final testLocation = LocationModel(
    city: 'Paris',
    countryName: 'France',
    lat: 48.8566,
    lon: 2.3522,
    region: 'Ile-de-France',
  );

  test('should add favorite location to the repository', () async {
    when(mockLocationRepository.addFavoritestLocation(testLocation))
        .thenAnswer((_) async => const Right(null));

    final result = await addFavoriteLocation(
        FavoriteLocationParams(location: testLocation));

    expect(result, const Right(null));
  });
}
