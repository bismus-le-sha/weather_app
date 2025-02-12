import 'package:weather_app/features/location/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel(
      {required super.countryName,
      required super.city,
      required super.region,
      required super.lat,
      required super.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      countryName: json['country'] as String,
      city: json['name'] as String,
      region: json['region'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': countryName,
      'name': city,
      'region': region,
      'lat': lat,
      'lon': lon,
    };
  }
}
