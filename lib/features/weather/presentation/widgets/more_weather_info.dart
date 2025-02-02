import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

class MoreWeatherInfo extends StatelessWidget {
  final WeatherEntity weather;

  const MoreWeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFeelsLikeText(),
          _buildConditionText(),
          _buildLastUpdatedText(),
          _buildWindSpeedText(),
        ],
      ),
    );
  }

  Widget _buildFeelsLikeText() {
    return Text(
      'Ощущается как ${weather.feelsLike.round()}°C',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildConditionText() {
    return Text(
      weather.conditionText.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildLastUpdatedText() {
    return Text(
      'Последнее обновление: ${DateFormat().add_jm().format(weather.lastUpdated)}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildWindSpeedText() {
    return Text(
      '${weather.windSpeed} km/h',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
