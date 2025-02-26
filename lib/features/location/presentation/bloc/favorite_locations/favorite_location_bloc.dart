import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/usecases/params/favorite_location_params.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/location.dart';
import '../../../domain/usecases/add_favorite_location.dart';
import '../../../domain/usecases/get_favorite_location_list.dart';
import '../../../domain/usecases/remove_favorite_location.dart';

part 'favorite_location_event.dart';
part 'favorite_location_state.dart';

class FavoriteLocationBloc
    extends Bloc<FavoriteLocationEvent, FavoriteLocationState> {
  final GetFavoriteLocationList getFavoriteLocationList;
  final AddFavoriteLocation addFavoriteLocation;
  final RemoveFavoriteLocation removeFavoriteLocation;

  FavoriteLocationBloc(
    this.getFavoriteLocationList,
    this.addFavoriteLocation,
    this.removeFavoriteLocation,
  ) : super(FavoriteLocationInitial()) {
    on<GetFavorite>(_onGetFavoriteLocationList);
    on<AddFavorite>(_onAddFavoriteLocation);
    on<RemoveFavorite>(_onRemoveFavoriteLocation);
  }

  Future<void> _onGetFavoriteLocationList(
      GetFavorite event, Emitter<FavoriteLocationState> emit) async {
    emit(FavoriteLocationLoading());
    final result = await getFavoriteLocationList(NoParams());
    result.fold(
      (failure) => emit(FavoriteLocationFailure(failure.message)),
      (data) => emit(FavoriteLocationLoaded(data)),
    );
  }

  Future<void> _updateFavoriteLocationList(
      Emitter<FavoriteLocationState> emit) async {
    final result = await getFavoriteLocationList(NoParams());
    result.fold(
      (failure) => emit(FavoriteLocationFailure(failure.message)),
      (updatedData) => emit(FavoriteLocationLoaded(updatedData)),
    );
  }

  Future<void> _onAddFavoriteLocation(
      AddFavorite event, Emitter<FavoriteLocationState> emit) async {
    emit(FavoriteLocationLoading());
    final result = await addFavoriteLocation(
      FavoriteLocationParams(location: event.location),
    );
    await result.fold(
      (failure) async {
        emit(FavoriteLocationFailure(failure.message));
      },
      (data) async {
        await _updateFavoriteLocationList(emit);
      },
    );
  }

  Future<void> _onRemoveFavoriteLocation(
      RemoveFavorite event, Emitter<FavoriteLocationState> emit) async {
    emit(FavoriteLocationLoading());
    final result = await removeFavoriteLocation(
      FavoriteLocationParams(location: event.location),
    );
    await result.fold(
      (failure) async {
        emit(FavoriteLocationFailure(failure.message));
      },
      (data) async {
        await _updateFavoriteLocationList(emit);
      },
    );
  }
}
