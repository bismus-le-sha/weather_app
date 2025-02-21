part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class OnLocationChanged extends LocationEvent {
  final String cityName;

  const OnLocationChanged(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class ClearLocation extends LocationEvent {}
