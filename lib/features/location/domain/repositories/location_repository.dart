import 'package:dartz/dartz.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';

import '../../../../core/error/failures.dart';

abstract class LocationRepository {
  Future<Either<Failure, List<LocationEntity>>> getListLocation(String query);
}
