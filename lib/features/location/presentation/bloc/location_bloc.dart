import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/features/location/domain/usecases/get_location.dart';
import 'package:weather_app/features/location/domain/usecases/params/location_params.dart';

import '../../domain/entities/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocation getLocation;

  LocationBloc(this.getLocation) : super(LocationInitial()) {
    on<OnLocationChanged>(
      (event, emit) async {
        if (event.cityName.trim().isEmpty) {
          emit(LocationInitial());
          return;
        }

        emit(LocationLoading());
        final result = await getLocation(LocationParams(query: event.cityName));
        result.fold(
          (failure) => emit(LocationFailure(failure.message)),
          (data) => emit(LocationLoaded(data)),
        );
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }
}
