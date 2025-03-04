import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/params/location_params.dart';
import 'package:weather_app/features/location/presentation/bloc/suggested_locations/location_bloc.dart';
import '../../../../../fixtures/fixture_reader.dart';
import '../../../../../helpers/test_helper.mocks.dart';

void main() {
  late LocationBloc locationBloc;
  late MockGetLocationList mockGetLocationList;

  setUp(() {
    mockGetLocationList = MockGetLocationList();
    locationBloc = LocationBloc(mockGetLocationList);
  });

  final testLocationList =
      (json.decode(fixture('dummy_location_response.json')) as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();

  group('LocationBloc', () {
    test('initial state should be LocationInitial', () {
      expect(locationBloc.state, LocationInitial());
    });

    blocTest<LocationBloc, LocationState>(
      'emits [LocationLoading, LocationLoaded] when getLocation succeeds',
      build: () {
        when(mockGetLocationList(any))
            .thenAnswer((_) async => Right(testLocationList));
        return locationBloc;
      },
      act: (bloc) => bloc.add(OnLocationChanged('New York')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        LocationLoading(),
        LocationLoaded(testLocationList),
      ],
      verify: (_) {
        verify(mockGetLocationList(LocationParams(query: 'New York')));
      },
    );

    blocTest<LocationBloc, LocationState>(
      'emits [LocationLoading, LocationFailure] when getLocation fails',
      build: () {
        when(mockGetLocationList(any)).thenAnswer(
          (_) async => Left(Failure.fromType(FailureType.serverError)),
        );
        return locationBloc;
      },
      act: (bloc) => bloc.add(OnLocationChanged('Invalid City')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        LocationLoading(),
        LocationFailure('Server error occurred'),
      ],
      verify: (_) {
        verify(mockGetLocationList(LocationParams(query: 'Invalid City')));
      },
    );

    blocTest<LocationBloc, LocationState>(
      'emits [LocationInitial] when query is empty',
      build: () => locationBloc,
      act: (bloc) => bloc.add(OnLocationChanged('')),
      expect: () => [LocationInitial()],
    );

    blocTest<LocationBloc, LocationState>(
      'emits [LocationInitial] when ClearLocation is added',
      build: () => locationBloc,
      act: (bloc) => bloc.add(ClearLocation()),
      expect: () => [LocationInitial()],
    );
  });
}
