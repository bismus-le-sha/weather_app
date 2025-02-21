import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.countryName,
    required this.city,
    required this.region,
    required this.lat,
    required this.lon,
  });

  final String countryName;
  final String city;
  final String region;
  final double lat;
  final double lon;

  @override
  List<Object?> get props => [
        countryName,
        city,
        region,
        lat,
        lon,
      ];
}
