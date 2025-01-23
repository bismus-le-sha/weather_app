import 'package:intl/intl.dart';

import '../../domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.cityName,
      required super.lastUpdated,
      required super.temperature,
      required super.feelsLike,
      required super.isDay,
      required super.conditionCode,
      required super.conditionText,
      required super.conditionIconUrl,
      required super.windSpeed});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd H:mm');
    return WeatherModel(
      cityName: json['location']['name'],
      lastUpdated: dateFormat.parse(json['current']['last_updated']),
      temperature: json['current']['temp_c'].toDouble(),
      feelsLike: json['current']['feelslike_c'].toDouble(),
      isDay: json['current']['is_day'].toInt(),
      conditionCode: json['current']['condition']['code'].toInt(),
      conditionText: json['current']['condition']['text'],
      conditionIconUrl: 'https:${json['current']['condition']['icon']}',
      windSpeed: json['current']['wind_kph'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd H:mm');
    return {
      'location': {
        'name': cityName,
      },
      'current': {
        'last_updated': dateFormat.format(lastUpdated),
        'temp_c': temperature,
        'feelslike_c': feelsLike,
        'is_day': isDay,
        'condition': {
          'code': conditionCode,
          'text': conditionText,
          'icon': conditionIconUrl.replaceFirst('https:', ''),
        },
        'wind_kph': windSpeed,
      },
    };
  }
}
