import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/presentation/bloc/favorite_locations/favorite_location_bloc.dart';

import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late FavoriteLocationBloc favoriteLocationBloc;
  late MockGetFavoriteLocationList mockGetFavoriteLocationList;
  late MockAddFavoriteLocation mockAddFavoriteLocation;
  late MockRemoveFavoriteLocation mockRemoveFavoriteLocation;

  setUp(() {
    mockGetFavoriteLocationList = MockGetFavoriteLocationList();
    mockAddFavoriteLocation = MockAddFavoriteLocation();
    mockRemoveFavoriteLocation = MockRemoveFavoriteLocation();
    favoriteLocationBloc = FavoriteLocationBloc(
      mockGetFavoriteLocationList,
      mockAddFavoriteLocation,
      mockRemoveFavoriteLocation,
    );
  });

  final testLocation = LocationModel(
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

  group('FavoriteLocationBloc', () {
    test('initial state should be FavoriteLocationInitial', () {
      expect(favoriteLocationBloc.state, FavoriteLocationInitial());
    });

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationLoaded] when GetFavorite succeeds',
      build: () {
        when(mockGetFavoriteLocationList(NoParams()))
            .thenAnswer((_) async => Right(testLocationList));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(GetFavorite()),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationLoaded(testLocationList),
      ],
      verify: (_) {
        verify(mockGetFavoriteLocationList(NoParams()));
      },
    );

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationFailure] when GetFavorite fails',
      build: () {
        when(mockGetFavoriteLocationList(NoParams())).thenAnswer(
            (_) async => Left(Failure.fromType(FailureType.serverError)));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(GetFavorite()),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationFailure('Server error occurred'),
      ],
    );

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationLoaded] when AddFavorite succeeds',
      build: () {
        when(mockAddFavoriteLocation(any)).thenAnswer((_) async => Right(null));
        when(mockGetFavoriteLocationList(NoParams()))
            .thenAnswer((_) async => Right(testLocationList));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(AddFavorite(testLocation)),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationLoaded(testLocationList),
      ],
    );

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationFailure] when AddFavorite fails',
      build: () {
        when(mockAddFavoriteLocation(any)).thenAnswer(
            (_) async => Left(Failure.fromType(FailureType.serverError)));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(AddFavorite(testLocation)),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationFailure('Server error occurred'),
      ],
    );

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationLoaded] when RemoveFavorite succeeds',
      build: () {
        when(mockRemoveFavoriteLocation(any))
            .thenAnswer((_) async => Right(null));
        when(mockGetFavoriteLocationList(NoParams()))
            .thenAnswer((_) async => Right([]));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(RemoveFavorite(testLocation)),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationLoaded([]),
      ],
    );

    blocTest<FavoriteLocationBloc, FavoriteLocationState>(
      'emits [FavoriteLocationLoading, FavoriteLocationFailure] when RemoveFavorite fails',
      build: () {
        when(mockRemoveFavoriteLocation(any)).thenAnswer(
            (_) async => Left(Failure.fromType(FailureType.serverError)));
        return favoriteLocationBloc;
      },
      act: (bloc) => bloc.add(RemoveFavorite(testLocation)),
      expect: () => [
        FavoriteLocationLoading(),
        FavoriteLocationFailure('Server error occurred'),
      ],
    );
  });
}
