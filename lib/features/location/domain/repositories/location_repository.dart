import 'package:dartz/dartz.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../core/error/failures.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getListLocation(String query);
  Future<Either<Failure, List<LocationEntity>>> getFavoritestLocationList();
  Future<Either<Failure, void>> addFavoritestLocation(LocationModel location);
  Future<Either<Failure, void>> removeFavoritestLocation(
      LocationModel location);
}
