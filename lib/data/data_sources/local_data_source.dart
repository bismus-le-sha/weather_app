import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/models/weather_model.dart';

import '../../core/error/exceptions.dart';

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(String cityName, WeatherModel weather);
  Future<WeatherModel> getLastWeather(String cityName);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheWeather(String cityName, WeatherModel weather) {
    return sharedPreferences.setString(cityName, jsonEncode(weather.toJson()));
  }

  @override
  Future<WeatherModel> getLastWeather(String cityName) {
    final jsonString = sharedPreferences.getString(cityName);
    if (jsonString != null) {
      return Future.value(WeatherModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
