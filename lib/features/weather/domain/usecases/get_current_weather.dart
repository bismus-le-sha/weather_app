import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/usecases/params/weater_params.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather implements UseCase<WeatherEntity, WeatherParams> {
  final WeatherRepository weatherRepository;

  GetCurrentWeather(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherEntity>> call(WeatherParams params) {
    return weatherRepository.getCurrentWeather(params.cityName);
  }
}
