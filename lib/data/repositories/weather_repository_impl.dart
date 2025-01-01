import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';

import '../../core/error/failures.dart';
import '../../core/util/network/network_ifo.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.weatherLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather =
            await weatherRemoteDataSource.getCurrentWeather(cityName);

        weatherLocalDataSource.cacheWeather(cityName, remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(Failure.fromType(FailureType.serverError));
      } on SocketException {
        return Left(Failure.fromType(FailureType.connectionError));
      }
    } else {
      try {
        final localWeather =
            await weatherLocalDataSource.getLastWeather(cityName);
        return Right(localWeather);
      } on CacheException {
        return Left(Failure.fromType(FailureType.cacheError));
      }
    }
  }
}
