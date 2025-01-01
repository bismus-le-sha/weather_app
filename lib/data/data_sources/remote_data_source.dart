import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/url_handler.dart';
import '../../core/error/exceptions.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      return WeatherModel.fromJson(jsonDecode(decodedBody));
    } else {
      throw ServerException();
    }
  }
}
