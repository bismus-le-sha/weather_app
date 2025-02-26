part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<LocationEntity> locationList;

  const LocationLoaded(this.locationList);

  @override
  List<Object> get props => [locationList];
}

class LocationFailure extends LocationState {
  final String message;

  const LocationFailure(this.message);

  @override
  List<Object> get props => [message];
}
