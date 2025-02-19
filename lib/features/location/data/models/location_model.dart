import 'package:weather_app/features/location/domain/entities/location.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required super.countryName,
    required super.city,
    required super.region,
    required super.lat,
    required super.lon,
  });

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

  LocationModel copyWith({
    String? countryName,
    String? city,
    String? region,
    double? lat,
    double? lon,
  }) {
    return LocationModel(
      countryName: countryName ?? this.countryName,
      city: city ?? this.city,
      region: region ?? this.region,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  @override
  String toString() {
    return 'LocationModel(city: $city, region: $region, country: $countryName, lat: $lat, lon: $lon)';
  }
}
