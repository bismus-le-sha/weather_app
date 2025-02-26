part of 'favorite_location_bloc.dart';

sealed class FavoriteLocationEvent extends Equatable {
  const FavoriteLocationEvent();

  @override
  List<Object> get props => [];
}

class GetFavorite extends FavoriteLocationEvent {}

class AddFavorite extends FavoriteLocationEvent {
  final LocationModel location;

  const AddFavorite(this.location);

  @override
  List<Object> get props => [location];
}

class RemoveFavorite extends FavoriteLocationEvent {
  final LocationModel location;

  const RemoveFavorite(this.location);

  @override
  List<Object> get props => [location];
}
