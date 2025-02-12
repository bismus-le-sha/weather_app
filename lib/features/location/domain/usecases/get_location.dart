import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

import 'params/location_params.dart';

class GetLocation implements UseCase<List<LocationEntity>, LocationParams> {
  final LocationRepository locationRepository;

  GetLocation(this.locationRepository);
  @override
  Future<Either<Failure, List<LocationEntity>>> call(params) {
    return locationRepository.getListLocation(params.query);
  }
}
