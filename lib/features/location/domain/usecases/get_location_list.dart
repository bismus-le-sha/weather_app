import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

import 'params/location_params.dart';

class GetLocationList implements UseCase<List<LocationEntity>, LocationParams> {
  final LocationRepository locationRepository;

  GetLocationList(this.locationRepository);
  @override
  Future<Either<Failure, List<LocationEntity>>> call(params) async {
    return locationRepository.getListLocation(params.query);
  }
}
