import 'package:equatable/equatable.dart';
import 'package:weather_app/features/location/data/models/location_model.dart';

class FavoriteLocationParams extends Equatable {
  final LocationModel location;

  const FavoriteLocationParams({required this.location});

  @override
  List<Object?> get props => [location];
}
