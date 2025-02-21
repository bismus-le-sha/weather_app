import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

import '../../features/location/presentation/pages/location_page.dart';
import '../../features/weather/presentation/pages/weather_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LocationRoute.page, path: '/location', initial: true),
        AutoRoute(page: WeatherRoute.page, path: '/weather/:cityName'),
      ];
}
