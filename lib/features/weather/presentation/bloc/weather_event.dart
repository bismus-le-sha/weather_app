import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class WeatherLoad extends WeatherEvent {
  final String cityName;

  const WeatherLoad(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class StartAutoUpdate extends WeatherEvent {
  final String cityName;

  const StartAutoUpdate(this.cityName);

  @override
  List<Object?> get props => [cityName];
}

class StopAutoUpdate extends WeatherEvent {}
