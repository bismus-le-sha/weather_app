// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CityPage]
class CityRoute extends PageRouteInfo<void> {
  const CityRoute({List<PageRouteInfo>? children})
    : super(CityRoute.name, initialChildren: children);

  static const String name = 'CityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CityPage();
    },
  );
}

/// generated route for
/// [WeatherPage]
class WeatherRoute extends PageRouteInfo<WeatherRouteArgs> {
  WeatherRoute({
    Key? key,
    required String cityName,
    List<PageRouteInfo>? children,
  }) : super(
         WeatherRoute.name,
         args: WeatherRouteArgs(key: key, cityName: cityName),
         initialChildren: children,
       );

  static const String name = 'WeatherRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WeatherRouteArgs>();
      return WeatherPage(key: args.key, cityName: args.cityName);
    },
  );
}

class WeatherRouteArgs {
  const WeatherRouteArgs({this.key, required this.cityName});

  final Key? key;

  final String cityName;

  @override
  String toString() {
    return 'WeatherRouteArgs{key: $key, cityName: $cityName}';
  }
}
