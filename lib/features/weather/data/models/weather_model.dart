import 'package:intl/intl.dart';

import '../../domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required super.cityName,
      required super.localtime,
      required super.temperature,
      required super.feelsLike,
      required super.conditionCode,
      required super.conditionText,
      required super.conditionIconUrl,
      required super.windSpeed});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd H:mm');
    return WeatherModel(
      cityName: json['location']['name'],
      localtime: dateFormat.parse(json['location']['localtime']),
      temperature: json['current']['temp_c'].toDouble(),
      feelsLike: json['current']['feelslike_c'].toDouble(),
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
        'localtime': dateFormat.format(localtime),
      },
      'current': {
        'temp_c': temperature,
        'feelslike_c': feelsLike,
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
