part of 'favorite_location_bloc.dart';

sealed class FavoriteLocationState extends Equatable {
  const FavoriteLocationState();

  @override
  List<Object> get props => [];
}

final class FavoriteLocationInitial extends FavoriteLocationState {}

final class FavoriteLocationLoading extends FavoriteLocationState {}

final class FavoriteLocationLoaded extends FavoriteLocationState {
  final List<LocationEntity> locationList;

  const FavoriteLocationLoaded(this.locationList);

  @override
  List<Object> get props => [locationList];
}

final class FavoriteLocationFailure extends FavoriteLocationState {
  final String message;

  const FavoriteLocationFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class FavoriteLocationAdded extends FavoriteLocationState {}

final class FavoriteLocationRemoved extends FavoriteLocationState {}
