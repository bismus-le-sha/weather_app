import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.lastUpdated,
    required this.temperature,
    required this.feelsLike,
    required this.isDay,
    required this.conditionCode,
    required this.conditionText,
    required this.conditionIconUrl,
    required this.windSpeed,
  });

  final String cityName;
  final DateTime lastUpdated;
  final double temperature;
  final double feelsLike;
  final int isDay;
  final int conditionCode;
  final String conditionText;
  final String conditionIconUrl;
  final double windSpeed;

  @override
  List<Object?> get props => [
        cityName,
        lastUpdated,
        temperature,
        feelsLike,
        isDay,
        conditionCode,
        conditionText,
        conditionIconUrl,
        windSpeed,
      ];
}
