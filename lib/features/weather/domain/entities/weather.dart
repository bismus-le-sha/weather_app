import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.localtime,
    required this.temperature,
    required this.feelsLike,
    required this.conditionCode,
    required this.conditionText,
    required this.conditionIconUrl,
    required this.windSpeed,
  });

  final String cityName;
  final DateTime localtime;
  final double temperature;
  final double feelsLike;
  final int conditionCode;
  final String conditionText;
  final String conditionIconUrl;
  final double windSpeed;

  @override
  List<Object?> get props => [
        cityName,
        localtime,
        temperature,
        feelsLike,
        conditionCode,
        conditionText,
        conditionIconUrl,
        windSpeed,
      ];
}
