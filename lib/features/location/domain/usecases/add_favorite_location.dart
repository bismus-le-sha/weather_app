import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:weather_app/features/location/domain/usecases/params/favorite_location_params.dart';

class AddFavoriteLocation implements UseCase<void, FavoriteLocationParams> {
  final LocationRepository locationRepository;

  AddFavoriteLocation(this.locationRepository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return locationRepository.addFavoritestLocation(params.location);
  }
}
