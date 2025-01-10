import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';

import '../../../features/weather/domain/entities/weather.dart';

import '../../../features/weather/domain/usecases/params/weater_params.dart';

import '../../error/failures.dart';

abstract class PeriodicWeatherUpdater {
  Stream<Either<Failure, WeatherEntity>> start(
      String cityName, Duration interval);
  void stop();
}

class PeriodicWeatherUpdaterImpl implements PeriodicWeatherUpdater {
  final GetCurrentWeather updateWeatherPeriodically;
  StreamController<Either<Failure, WeatherEntity>>? _controller;

  PeriodicWeatherUpdaterImpl(this.updateWeatherPeriodically);

  @override
  Stream<Either<Failure, WeatherEntity>> start(
      String cityName, Duration interval) {
    _controller = StreamController<Either<Failure, WeatherEntity>>();
    _emitPeriodicUpdates(cityName, interval);
    return _controller!.stream;
  }

  void _emitPeriodicUpdates(String cityName, Duration interval) async {
    while (_controller != null && !_controller!.isClosed) {
      final result = await updateWeatherPeriodically(
        WeatherParams(cityName: cityName),
      );
      _controller!.add(result);
      await Future.delayed(interval);
    }
  }

  @override
  void stop() {
    _controller?.close();
    _controller = null;
  }
}
