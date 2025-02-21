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
      _onLocationChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .distinct((prev, curr) => prev.cityName == curr.cityName)
          .switchMap(mapper),
    );
    on<ClearLocation>(_onClearLocation);
  }

  Future<void> _onLocationChanged(
      OnLocationChanged event, Emitter<LocationState> emit) async {
    final query = event.cityName.trim();
    if (query.isEmpty) {
      emit(LocationInitial());
      return;
    }

    emit(LocationLoading());

    final result = await getLocation(LocationParams(query: query));
    result.fold(
      (failure) => emit(LocationFailure(failure.message)),
      (data) => emit(LocationLoaded(data)),
    );
  }

  Future<void> _onClearLocation(
      ClearLocation event, Emitter<LocationState> emit) async {
    return emit(LocationInitial());
  }
}
