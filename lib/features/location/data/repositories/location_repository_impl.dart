import 'package:dartz/dartz.dart';

import 'package:weather_app/core/error/failures.dart';

import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/remote_location_data_source.dart';

class LocationRepositoryImpl extends LocationRepository {
  final LocationDataSource locationDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl(
      {required this.locationDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<LocationEntity>>> getListLocation(
      String query) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await locationDataSource.getLocationList(query));
      } on ServerException {
        return Left(Failure.fromType(FailureType.serverError));
      }
    } else {
      return Left(Failure.fromType(FailureType.connectionError));
    }
  }
}
