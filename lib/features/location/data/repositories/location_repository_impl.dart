import 'package:dartz/dartz.dart';

import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/location/data/datasources/local_location_data_source.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/remote_location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RemoteLocationDataSource remoteLocationDataSource;
  final LocalLocationDataSource localLocationDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl(
      {required this.remoteLocationDataSource,
      required this.localLocationDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<LocationEntity>>> getListLocation(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteLocationDataSource.getLocationList(query));
      } on ServerException {
        return Left(Failure.fromType(FailureType.serverError));
      }
    } else {
      return Left(Failure.fromType(FailureType.connectionError));
    }
  }

  @override
  Future<Either<Failure, void>> addFavoritestLocation(
      LocationModel location) async {
    try {
      return Right(await localLocationDataSource.addFavoriteLocation(location));
    } on CacheException {
      return Left(Failure.fromType(FailureType.cacheError));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>>
      getFavoritestLocationList() async {
    try {
      return Right(await localLocationDataSource.getFavoriteLocationList());
    } on CacheException {
      return Left(Failure.fromType(FailureType.cacheError));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoritestLocation(
      LocationModel location) async {
    try {
      return Right(
          await localLocationDataSource.removeFavoriteLocation(location));
    } on CacheException {
      return Left(Failure.fromType(FailureType.cacheError));
    }
  }
}
