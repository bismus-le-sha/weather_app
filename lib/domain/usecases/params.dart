import 'package:equatable/equatable.dart';

class WeatherParams extends Equatable {
  final String cityName;

  const WeatherParams({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
