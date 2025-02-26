import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

class GetFavoriteLocationList
    implements UseCase<List<LocationEntity>, NoParams> {
  final LocationRepository locationRepository;

  GetFavoriteLocationList(this.locationRepository);
  @override
  Future<Either<Failure, List<LocationEntity>>> call(NoParams params) async {
    return locationRepository.getFavoritestLocationList();
  }
}
