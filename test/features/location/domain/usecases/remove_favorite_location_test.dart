import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/params/favorite_location_params.dart';
import 'package:weather_app/features/location/domain/usecases/remove_favorite_location.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveFavoriteLocation removeFavoriteLocation;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    removeFavoriteLocation = RemoveFavoriteLocation(mockLocationRepository);
  });

  final testLocation = LocationModel(
    city: 'Paris',
    countryName: 'France',
    lat: 48.8566,
    lon: 2.3522,
    region: 'Ile-de-France',
  );

  test('should remove favorite location from the repository', () async {
    when(mockLocationRepository.removeFavoritestLocation(testLocation))
        .thenAnswer((_) async => const Right(null));

    final result = await removeFavoriteLocation(
        FavoriteLocationParams(location: testLocation));

    expect(result, const Right(null));
  });
}
